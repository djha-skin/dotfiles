#! /usr/bin/env python
import subprocess

def multipass(url,username):
    return subprocess.run([f"multipass",url, username],
                          capture_output=True,
                          check=True,
                          text=True).stdout.splitlines()[0]