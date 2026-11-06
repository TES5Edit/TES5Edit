"""Create a disposable in-memory patch and remove only its copied override; never save."""
import argparse
import urllib.parse
import uuid

from verify_changesets import call


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', default='http://127.0.0.1:7000')
    parser.add_argument('--token')
    parser.add_argument('--source', default='Skyrim.esm')
    parser.add_argument('--record', default='00012FD0')
    args = parser.parse_args()

    def request(path, body=None, key=None):
        return call(args.base, path, body, key, args.token)

    def tree(file):
        return request('/api/plugins/' + urllib.parse.quote(file, safe='') +
                       '/records/' + args.record + '/tree?depth=20')

    def remove(**extra):
        body = dict(op)
        key = extra.pop('key', None)
        body.update(extra)
        status, result = request('/api/batch', {'strict': True, 'ops': [body]}, key)
        assert status == 200, (status, result)
        return result

    source_before = tree(args.source)
    assert source_before[0] == 200, source_before
    global_before = request('/api/records/' + args.record)
    assert global_before[0] == 200, global_before
    patch = 'APIProbeOverride_' + uuid.uuid4().hex[:12] + '.esp'
    status, created = request('/api/patch', dict(fileName=patch, records=[
        dict(file=args.source, formID=args.record)]))
    assert status == 200 and created['ok'], (status, created)
    assert tree(patch)[0] == 200
    # Read exact identity and chain from the copied record's metadata.
    status, chain = request('/api/plugins/' + patch + '/records/' + args.record)
    assert status == 200 and chain['ok'], chain
    # Identity comes from a native EDID leaf rather than a guessed display name.
    status, identity = request('/api/plugins/' + patch + '/records/' + args.record + '/element?path=EDID')
    assert status == 200, identity
    master_file = chain['master']['containingFile']
    op = dict(op='remove-record', file=patch, formID=args.record, mode='override',
              expectedEditorID=identity['editValue'], expectedMasterFile=master_file,
              expectedWinningFile=patch)
    preview = remove(dryRun=True)
    assert preview['ok'] and preview['results'][0]['result']['state'] == 'preview', preview
    for extra in [dict(mode='new-record'), dict(expectedWinningFile='missing.esp'),
                  dict(expectedMasterFile='missing.esm')]:
        rejected = remove(**extra)
        assert not rejected['ok'] and rejected['results'][0]['result']['state'] == 'not_applied', rejected
        assert tree(patch)[0] == 200
    key = 'override-remove-' + uuid.uuid4().hex
    removed = remove(key=key)
    assert removed['ok'] and removed['results'][0]['result']['state'] == 'applied', removed
    assert tree(patch)[0] == 404
    assert tree(args.source) == source_before
    assert request('/api/records/' + args.record) == global_before
    assert remove(key=key) == removed
    print('PASS: override copy, preview, mode/chain guards, removal, original/chain restoration, replay')
    print('No saves; empty temporary plugin remains in memory:', patch)


if __name__ == '__main__':
    main()
