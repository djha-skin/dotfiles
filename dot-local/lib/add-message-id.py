import re
import sys
import uuid

find_from  = re.compile(r'^From *: [^<]*<(?P<user>[^@]+)@(?P<host>[^>]+)>.*$')
find_message_id = re.compile(
        r'^Message-ID *: *(?P<msg>[^@]+)@(?P<host>[^@\s]+).*$'
        )

new_message_id = None
for l in sys.stdin:
    line = l.strip()
    found_from = find_from.search(line)
    found_message_id = find_message_id.search(line)
    if not found_message_id:
        print(l, end='')
    if found_from:
        new_message_id = '{user}.{guid}@{host}'.format(
                user=found_from.group('user'),
                guid=re.sub('[\W_]+', '.', str(uuid.uuid1())),
                host=found_from.group('host'))
        print(f'Message-ID: <{new_message_id}>')
