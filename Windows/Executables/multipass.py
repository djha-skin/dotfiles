import subprocess
import re
import pprint
import sys

find_pass = re.compile(r"password=(?P<pass>.*)$")
out = subprocess.run(
    ["git-credential-keepassxc", "get"],
    input="url={url}\nusername={username}\n".format(
        url=sys.argv[1], username=sys.argv[2]
    ).encode("utf-8", errors="ignore"),
    capture_output=True,
)
lines = out.stdout.decode("utf-8", errors="ignore")
for line in lines.split():
    m = find_pass.search(line)
    if m:
        print(m.group("pass"))
        sys.exit(0)
sys.exit(1)