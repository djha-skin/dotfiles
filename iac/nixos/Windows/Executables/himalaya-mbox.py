import sys
import subprocess
import argparse


def print_mbox(account):
    for i in sys.stdin.read().splitlines():
        print("")
        print("From nobody Mon Sep 17 00:00:00 2001")
        print(
            "{email}".format(
                email=subprocess.run(
                    [
                        "himalaya",
                        "-a",
                        account,
                        "read",
                        "--raw",
                        "--sanitize",
                        i,
                    ],
                    capture_output=True,
                ).stdout.decode("utf-8", errors="ignore")
            ),
            end="",
        )
        print("")


def main(argv):
    mbox_parser = argparse.ArgumentParser(
        "Print out an mbox from emails, powered by himalaya"
    )
    mbox_parser.add_argument(
        "--account",
        "-a",
        type=str,
        default=None,
        metavar="ACCOUNT",
        required=True,
        help="which account to use?",
    )
    args = mbox_parser.parse_args(argv)
    print_mbox(args.account)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))