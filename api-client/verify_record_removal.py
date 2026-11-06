"""Opt-in in-memory create/remove integration test. Never saves plugins."""
import argparse
import urllib.parse
import uuid

from verify_changesets import call


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', default='http://127.0.0.1:7000')
    parser.add_argument('--token')
    parser.add_argument('--file', required=True, help='Loaded, editable test plugin')
    args = parser.parse_args()
    prefix = '/api/plugins/' + urllib.parse.quote(args.file, safe='') + '/records/'

    def batch(op, key=None):
        status, body = call(args.base, '/api/batch',
                            {'strict': True, 'ops': [dict(file=args.file, **op)]},
                            key=key, token=args.token)
        assert status == 200, (status, body)
        return body

    # Each probe is new; pre-existing user records are never removed.
    name = 'APIProbeRemove_' + uuid.uuid4().hex[:12]
    created = batch(dict(op='create-empty-record', signature='SPEL', editorID=name))
    assert created['ok'], created
    fid = created['results'][0]['result']['formID']
    removal = dict(op='remove-record', formID=fid, mode='new-record', expectedEditorID=name)
    preview = batch(dict(removal, dryRun=True))
    assert preview['ok'] and preview['results'][0]['result']['state'] == 'preview', preview
    rejected = batch(dict(removal, expectedEditorID=name + '_wrong'))
    assert not rejected['ok'], rejected
    assert rejected['results'][0]['result']['state'] == 'not_applied', rejected
    assert call(args.base, prefix + fid, token=args.token)[0] == 200
    # A second disposable record supplies a real incoming reference.
    list_name = name + '_List'
    created_list = batch(dict(op='create-empty-record', signature='FLST', editorID=list_name))
    assert created_list['ok'], created_list
    list_id = created_list['results'][0]['result']['formID']
    added = batch(dict(op='add-element', formID=list_id, path='', signature='LNAM'))
    assert added['ok'], added
    linked = batch(dict(op='set-link', formID=list_id, path='FormIDs\\0',
                        source=dict(file=args.file, formID=fid)))
    assert linked['ok'], linked
    before = call(args.base, prefix + fid + '/tree?depth=20', token=args.token)
    blocked = batch(removal)
    assert not blocked['ok'] and 'incoming references' in blocked['results'][0]['error'], blocked
    assert blocked['results'][0]['result']['state'] == 'not_applied', blocked
    assert call(args.base, prefix + fid + '/tree?depth=20', token=args.token) == before
    detached = batch(dict(op='remove-element', formID=list_id, path='FormIDs'))
    assert detached['ok'], detached
    removed_list = batch(dict(op='remove-record', formID=list_id, mode='new-record',
                             expectedEditorID=list_name))
    assert removed_list['ok'], removed_list
    assert call(args.base, prefix + list_id, token=args.token)[0] == 404
    key = 'remove-probe-' + uuid.uuid4().hex
    removed = batch(removal, key)
    assert removed['ok'] and removed['results'][0]['result']['state'] == 'applied', removed
    assert call(args.base, prefix + fid, token=args.token)[0] == 404
    assert batch(removal, key) == removed
    missing = batch(removal)
    assert not missing['ok'] and missing['results'][0]['result']['state'] == 'not_applied', missing
    print('PASS: create, preview, EDID guard, incoming-reference guard, detach, native removal, 404, replay, missing-record rejection')
    print('No saves. Creation may advance the in-memory next FormID counter or leave an empty group.')


if __name__ == '__main__':
    main()
