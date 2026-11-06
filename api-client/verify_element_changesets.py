"""Opt-in add-element/rollback integration test; edits memory only and never saves."""
import argparse
import urllib.parse
import uuid
import copy

from verify_changesets import call


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', default='http://127.0.0.1:7000')
    parser.add_argument('--token')
    parser.add_argument('--file', default='SCSI-UBERace-Patch.esp')
    parser.add_argument('--record', default='05005734')
    parser.add_argument('--parent', default='Actor Effects')
    parser.add_argument('--template', default='Actor Effect')
    args = parser.parse_args()

    def visible_content(response):
        result = copy.deepcopy(response)
        # Native raw snapshot serialization refreshes this derived header field.
        def walk(node):
            if node.get('name') == 'Record Header':
                node['children'] = [c for c in node.get('children', []) if c.get('name') != 'Data Size']
            for child in node.get('children', []):
                walk(child)
        walk(result[1].get('tree', {}))
        return result

    def request(path, body=None, key=None):
        return call(args.base, path, body, key, args.token)

    prefix = '/api/plugins/' + urllib.parse.quote(args.file, safe='') + '/records/' + args.record
    before = request(prefix + '/tree?depth=32')
    assert before[0] == 200, before
    status, identity = request(prefix + '/element?path=FULL')
    assert status == 200, identity
    name = identity['editValue']
    body = dict(op='add-element', file=args.file, formID=args.record,
                path=args.parent, template=args.template, preconditions=[
                    dict(file=args.file, formID=args.record, path='FULL', equals=name)])
    key = 'element-cs-' + uuid.uuid4().hex
    status, applied = request('/api/element-changesets', body, key)
    assert status == 200 and applied['ok'] and applied['state'] == 'applied', applied
    assert applied['changes'] and applied['reversible'], applied
    cs_path = '/api/changesets/' + applied['changeSetID']
    assert request('/api/element-changesets', body, key) == (status, applied)
    assert request(cs_path) == (status, applied)
    # An unrelated subsequent edit must block rollback before any structural edit.
    changed_name = name + '_APIConflict'
    try:
        result = request(prefix + '/values', {'values': {'FULL': changed_name}})
        assert result[0] == 200 and result[1]['ok'], result
        conflict_tree = request(prefix + '/tree?depth=32')
        status, conflict = request(cs_path + '/rollback', {})
        assert status == 409 and conflict['error']['code'] == 'rollback_conflict', conflict
        assert visible_content(request(prefix + '/tree?depth=32')) == visible_content(conflict_tree)
    finally:
        restored = request(prefix + '/values', {'values': {'FULL': name}})
        assert restored[0] == 200 and restored[1]['ok'], restored
    status, rolled = request(cs_path + '/rollback', {})
    assert status == 200 and rolled['ok'] and rolled['state'] == 'rolled_back', rolled
    assert visible_content(request(prefix + '/tree?depth=32')) == visible_content(before)
    assert request(cs_path + '/rollback', {}) == (status, rolled)
    print('PASS: structural diff, replay, inspection, whole-record conflict guard, native rollback, exact tree restoration')
    print('No saves. Server also verifies raw record and plugin metadata restoration.')


if __name__ == '__main__':
    main()
