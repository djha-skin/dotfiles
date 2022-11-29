from pathlib import Path
import argparse
import sys
import io


def pushd(directory, wdh_path, **kwargs):
    with open(wdh_path, "a", encoding="utf-8", errors="ignore") as wdh:
        print(f"{str(directory)}", file=wdh)
    return 0


def last_dir(wdh_path, truncate=True, **kwargs):
    charspot = bytearray(1)
    if wdh_path.exists():
        if wdh_path.stat().st_size > 0:
            with open(wdh_path, "rb+") as wdh:
                cursor = wdh.seek(-2, io.SEEK_END)
                while True:
                    cursor += wdh.readinto(charspot)
                    if charspot == b"\n":
                        break

                    if cursor <= 1:
                        cursor = wdh.seek(0, io.SEEK_SET)
                        break
                    else:
                        cursor = wdh.seek(-2, io.SEEK_CUR)

                place = wdh.readline().decode("utf-8", errors="ignore")
                if truncate:
                    wdh.seek(cursor, io.SEEK_SET)
                    wdh.truncate()
            print(place.strip())
        else:
            print(f"Stack file `{wdh_path}` is empty", file=sys.stderr)
            return 3
    else:
        print(f"Stack file `{wdh_path}` does not exist", file=sys.stderr)
        return 2
    return 0


def peekd(wdh_path, **kwargs):

    last_dir(wdh_path, truncate=False, **kwargs)


def popd(wdh_path, **kwargs):

    last_dir(wdh_path, truncate=True, **kwargs)


def whathappened(parser, **kwargs):
    parser.print_usage(file=sys.stderr)
    return 1


def main(args):

    home = Path.home()
    location = home / ".wdh.txt"

    ap = argparse.ArgumentParser(
        prog="wdh", description="Manage working directories for you."
    )
    ap.add_argument(
        "-p",
        "--wdh-path",
        default=location,
        type=Path,
        help="What file to use for directory management.",
    )
    ap.set_defaults(parser=ap)
    ap.set_defaults(func=whathappened)
    subp = ap.add_subparsers()
    ap_peekd = subp.add_parser(
        "peek", help="Print directory at the top of the stack"
    )
    ap_peekd.set_defaults(func=peekd)
    ap_pushd = subp.add_parser(
        "push", help="Push directory onto the wdh stack"
    )
    ap_pushd.add_argument("directory", help="Directory to push")
    ap_pushd.set_defaults(func=pushd)
    ap_popd = subp.add_parser("pop", help="Pop directory from the wdh stack")
    ap_popd.set_defaults(func=popd)
    options = ap.parse_args(args)
    options.func(**options.__dict__)


if __name__ == "__main__":
    main(sys.argv[1:])
