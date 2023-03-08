from pathlib import Path
import argparse
import sys
import io


def pushd(directory, wdh_path, **kwargs):
    if directory.resolve().exists():
        with open(wdh_path, "a", encoding="utf-8", errors="ignore") as wdh:
            print(f"{str(directory.resolve())}", file=wdh)
        return 0
    else:
        print("Path does not exist", file=sys.stderr)
        return 4


def last_dir(wdh_path, truncate=True, **kwargs):
    index = kwargs.get("index", -1)
    dirs = []
    if wdh_path.exists():
        if wdh_path.stat().st_size > 0:
            with open(wdh_path, "r", encoding="utf-8", errors="ignore") as wdh:
                for line in wdh:
                    dirs.append(line.strip())
            return True, dirs[index]
        else:
            return True, None
    else:
        return False, None


def last_dir_cli(wdh_path, truncate=True, **kwargs):
    exists, path = last_dir(wdh_path, truncate, **kwargs)
    if exists and path is not None:
        print(path)
        return 0
    if exists:
        print(f"Stack file `{wdh_path}` is empty", file=sys.stderr)
        return 3

    print(f"Stack file `{wdh_path}` does not exist", file=sys.stderr)
    return 2


def peekd(wdh_path, **kwargs):
    last_dir_cli(wdh_path, truncate=False, **kwargs)


def popd(wdh_path, **kwargs):
    last_dir_cli(wdh_path, truncate=True, **kwargs)


def setd(directory, wdh_path, **kwargs):
    exists, path = last_dir(wdh_path, truncate=True)
    pushd(directory, wdh_path, **kwargs)


def listd(wdh_path, **kwargs):
    with open(wdh_path, "r", encoding="utf-8", errors="ignore") as wdh:
        sys.stdout.write(wdh.read())


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
    ap_listd = subp.add_parser("list", help="Show contents of the stack")
    ap_listd.set_defaults(func=listd)
    ap_peekd = subp.add_parser(
        "peek", help="Print directory. By default, print the top of the stack."
    )
    ap_peekd.set_defaults(func=peekd)
    ap_peekd.add_argument(
        "-i",
        "--index",
        help="Print some other directory at index",
        default=-1,
        type=int,
    )
    ap_pushd = subp.add_parser(
        "push", help="Push directory onto the wdh stack"
    )
    ap_pushd.add_argument("directory", help="Directory to push", type=Path)
    ap_pushd.set_defaults(func=pushd)

    ap_setd = subp.add_parser("set", help="Set top directory")
    ap_setd.add_argument("directory", help="Directory to set", type=Path)
    ap_setd.set_defaults(func=setd)

    ap_popd = subp.add_parser("pop", help="Pop directory from the wdh stack")
    ap_popd.set_defaults(func=popd)
    options = ap.parse_args(args)
    options.func(**options.__dict__)


if __name__ == "__main__":
    main(sys.argv[1:])
