"""Read-only smoke check for startup phases and cursor-based logs."""
import argparse
import json
import urllib.error
import urllib.request


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--base', default='http://127.0.0.1:7000')
    p.add_argument('--token', default='')
    args = p.parse_args()

    def get(path):
        req = urllib.request.Request(args.base + path)
        if args.token:
            req.add_header('Authorization', 'Bearer ' + args.token)
        try:
            response = urllib.request.urlopen(req, timeout=15)
        except urllib.error.HTTPError as exc:
            response = exc
        with response:
            return response.code, json.load(response)

    code, s = get('/api/status')
    assert code == 200 and s['ok'], s
    phase = s['phase']
    assert phase in {'initializing', 'waiting_for_selection',
                     'waiting_for_interaction', 'loading', 'ready', 'failed'}, s
    assert s['busy'] == (phase == 'loading'), s
    assert s['phaseDurationMs'] >= 0 and s['phaseSince'].endswith('Z'), s
    if phase == 'ready':
        assert s['pluginsLoaded'] and not s['loaderError'], s
    if phase == 'failed':
        assert s['lastLoadError'], s
    code, logs = get('/api/logs?after=0')
    assert code == 200 and logs['ok'], logs
    entries = logs['entries']
    assert len(entries) <= 200, logs
    sequences = [x['sequence'] for x in entries]
    assert sequences == sorted(set(sequences)), logs
    assert all(x['sequence'] <= logs['nextCursor'] for x in entries), logs
    cursor = logs['nextCursor']
    code, later = get('/api/logs?after=' + str(cursor))
    assert code == 200 and all(x['sequence'] > cursor for x in later['entries']), later
    code, invalid = get('/api/logs?after=-1')
    assert code == 400 and invalid['error']['code'] == 'bad_cursor', invalid
    print('PASS:', phase, 'durationMs=', s['phaseDurationMs'], 'logCursor=', cursor)


if __name__ == '__main__':
    main()
