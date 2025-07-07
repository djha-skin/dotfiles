import subprocess
import pprint
import json

exclude_folders = set(
    ["[Gmail]/All Mail", "[Gmail]/Chats", "[Gmail]/Spam", "[Gmail]/Important"]
)

folders = json.loads(
    subprocess.run(
        [
            "himalaya",
            "-a",
            "gmail",
            "-o",
            "json",
            "folders",
            "list",
        ],
        capture_output=True,
    ).stdout.decode("utf-8", errors="ignore")
)

for folder in folders:
    if folder["name"] not in exclude_folders:
        subprocess.run(
            [
                "himalaya",
                "-a",
                "gmail",
                "-f",
                folder["name"],
                "accounts",
                "sync",
            ]
        )