import json
import urllib.request
from urllib.error import HTTPError, URLError

URL = "https://api.maraka.co.ls/buyandsellDjango-apis/auth/login/"
identifier = "thabo@maraka.co.ls"
password = "Lekoba@1"

headers = {"Content-Type": "application/json"}

def post(payload):
    data = json.dumps(payload).encode('utf-8')
    req = urllib.request.Request(URL, data=data, headers=headers, method='POST')
    try:
        with urllib.request.urlopen(req, timeout=20) as resp:
            body = resp.read().decode('utf-8')
            return resp.getcode(), body
    except HTTPError as e:
        try:
            body = e.read().decode('utf-8')
        except Exception:
            body = ''
        return e.code, body
    except URLError as e:
        return None, str(e)

attempts = [
    ({'username': identifier, 'password': password}, 'username (email)'),
    ({'email': identifier, 'password': password}, 'email key'),
]

if '@' in identifier:
    local = identifier.split('@')[0]
    attempts.append(({'username': local, 'password': password}, 'local-part username'))

for payload, desc in attempts:
    print('---', desc, 'payload:', payload)
    code, body = post(payload)
    print('HTTP status:', code)
    print('Body:', body)

print('\nDone')
