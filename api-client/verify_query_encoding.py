"""Read-only query encoding regression against a rebuilt, loaded xEdit."""
import argparse
import urllib.parse

from verify_changesets import call


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', default='http://127.0.0.1:7000')
    parser.add_argument('--token')
    parser.add_argument('--file', required=True)
    parser.add_argument('--record', required=True)
    parser.add_argument('--path', required=True, help='Existing path containing a space')
    args = parser.parse_args()
    if ' ' not in args.path:
        parser.error('--path must contain a space')
    endpoint = '/api/plugins/' + urllib.parse.quote(args.file, safe='')
    endpoint += '/records/' + args.record + '/element?'
    encoded = urllib.parse.urlencode({'path': args.path})
    percent = urllib.parse.urlencode({'path': args.path}, quote_via=urllib.parse.quote)
    expected = call(args.base, endpoint + percent, token=args.token)
    assert expected[0] == 200 and expected[1]['ok'], expected
    actual = call(args.base, endpoint + encoded, token=args.token)
    assert actual == expected, (encoded, actual, percent, expected)
    # A percent-encoded literal plus must not alias the space-containing path.
    literal = urllib.parse.urlencode({'path': args.path.replace(' ', '+')})
    actual = call(args.base, endpoint + literal, token=args.token)
    assert actual != expected, (literal, actual)
    print('PASS: query + and %20 agree; %2B remains distinct; no edits performed')


if __name__ == '__main__':
    main()
