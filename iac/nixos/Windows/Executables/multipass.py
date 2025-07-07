import subprocess
import re
import pprint
import sys

find_pass = re.compile(r"password=(?P<pass>.*)$")
out = subprocess.run(
        ["C:/Users/bhw/.cargo/bin/git-credential-keepassxc", "get"],
    input="url={url}\nusername={username}\n".format(
        url=sys.argv[1], username=sys.argv[2]
    ).encode("utf-8", errors="ignore"),
    capture_output=True,
)
badlines = out.stderr.decode("utf-8", errors="ignore")
if badlines:
    print(badlines, file=sys.stderr)
    sys.exit(1)

lines = out.stdout.decode("utf-8", errors="ignore")
for line in lines.split():
    m = find_pass.search(line)
    if m:
        print(m.group("pass"), end="")
        sys.exit(0)
sys.exit(1)