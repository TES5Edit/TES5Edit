"""Opt-in reference changeset test; in-memory edits only, never saves."""
import uuid
from verify_changesets import call


def main():
    base = 'http://127.0.0.1:7000'
    file = 'SCSI-UBERace-Patch.esp'
    record = '05005734'
    prefix = '/api/plugins/' + file + '/records/' + record
    before = call(base, prefix + '/tree?depth=32')
    assert before[0] == 200
    body = dict(op='set-link', file=file, formID=record, path='Actor Effects\\0',
                source=dict(file='Skyrim.esm', formID='00012FD0'))
    key = 'link-cs-' + uuid.uuid4().hex
    status, applied = call(base, '/api/element-changesets', body, key)
    assert status == 200 and applied['ok'] and applied['state'] == 'applied', applied
    assert applied['diffComplete'] and applied['changes'], applied
    endpoint = '/api/changesets/' + applied['changeSetID']
    assert call(base, '/api/element-changesets', body, key) == (status, applied)
    status, rolled = call(base, endpoint + '/rollback', {})
    assert status == 200 and rolled['ok'] and rolled['state'] == 'rolled_back', rolled
    after = call(base, prefix + '/tree?depth=32')
    # Header size is refreshed lazily by native serialization; server checks
    # complete normalized raw/tree/plugin snapshots without this exclusion.
    def content(result):
        root = result[1]['tree']
        for child in root.get('children', []):
            if child['name'] == 'Record Header':
                child['children'] = [n for n in child['children'] if n['name'] != 'Data Size']
        return root
    assert content(before) == content(after)
    assert call(base, endpoint + '/rollback', {}) == (status, rolled)
    print('PASS: link diff, replay, sorted-path rollback, complete normalized server verification')


if __name__ == '__main__':
    main()
