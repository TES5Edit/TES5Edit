"""Create a temporary FLST, test null-reference rollback, remove it; never saves."""
import uuid
from verify_changesets import call


def main():
    base = 'http://127.0.0.1:7000'
    file = 'SCSI-UBERace-Patch.esp'
    name = 'APIProbeNull_' + uuid.uuid4().hex[:12]

    def batch(op):
        status, result = call(base, '/api/batch', {'ops': [dict(file=file, **op)]})
        assert status == 200 and result['ok'], result
        return result

    created = batch(dict(op='create-empty-record', signature='FLST', editorID=name))
    fid = created['results'][0]['result']['formID']
    prefix = '/api/plugins/' + file + '/records/' + fid
    batch(dict(op='add-element', formID=fid, path='', signature='LNAM'))
    body = dict(op='set-link', file=file, formID=fid, path='FormIDs\\0',
                source=dict(file='Skyrim.esm', formID='00012FD0'))
    key = 'null-link-' + uuid.uuid4().hex
    status, applied = call(base, '/api/element-changesets', body, key)
    assert status == 200 and applied['ok'] and applied['state'] == 'applied', applied
    assert call(base, '/api/element-changesets', body, key) == (status, applied)
    endpoint = '/api/changesets/' + applied['changeSetID'] + '/rollback'
    status, rolled = call(base, endpoint, {})
    assert status == 200 and rolled['ok'] and rolled['state'] == 'rolled_back', rolled
    status, element = call(base, prefix + '/element?path=FormIDs%5C0')
    assert status == 200 and '[00000000]' in element['editValue'], element
    assert call(base, endpoint, {}) == (200, rolled)
    batch(dict(op='remove-record', formID=fid, mode='new-record', expectedEditorID=name))
    assert call(base, prefix)[0] == 404
    print('PASS: null -> loaded target -> verified null restoration, replay, temporary record cleanup')


if __name__ == '__main__':
    main()
