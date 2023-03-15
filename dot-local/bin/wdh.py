from pathlib import Path
import argparse
import sys


def read_dirs(wdh_path):
    dirs = []
    if wdh_path.exists() and wdh_path.stat().st_size > 0:
        with open(wdh_path, "r", encoding="utf-8", errors="ignore") as wdh:
            for line in wdh:
                dirs.append(line.strip())
    return dirs


def write_dirs(wdh_path, dirs):
    with open(wdh_path, "w", encoding="utf-8", errors="ignore") as wdh:
        for i in range(len(dirs)):
            print(dirs[i], file=wdh)


def pushd(directory, wdh_path, **kwargs):
    index = kwargs["index"]
    full_dir = directory.resolve()
    new_entry = str(full_dir)

    if full_dir.exists():
        dirs = read_dirs(wdh_path)
        after_index = (index + len(dirs) + 1) % (len(dirs) + 1)
        dirs.insert(after_index, new_entry)
        write_dirs(wdh_path, dirs)
    else:
        print("Path does not exist", file=sys.stderr)
        return 4


def peek(wdh_path, index, **kwargs):
    dirs = read_dirs(wdh_path)
    if len(dirs) > 0:
        print(dirs[index])
    return dirs


def peekd(wdh_path, index, **kwargs):
    peek(wdh_path, index, **kwargs)
    return 0


def popd(wdh_path, index, **kwargs):
    dirs = peek(wdh_path, index, **kwargs)
    dirs.pop(index)
    write_dirs(wdh_path, dirs)


def setd(wdh_path, directory, index, **kwargs):
    if directory.exists():
        dirs = read_dirs(wdh_path)
        dirs[index] = str(directory.resolve())
        write_dirs(wdh_path, dirs)
    else:
        print("Path does not exist", file=sys.stderr)
        return 4


def listd(wdh_path, **kwargs):
    dirs = read_dirs(wdh_path)
    for i in range(len(dirs)):
        print(f"{i} {dirs[i]}")


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
    ap_pushd.add_argument(
        "-i",
        "--index",
        help="Push after some other directory index",
        default=-1,
        type=int,
    )
    ap_pushd.set_defaults(func=pushd)

    ap_setd = subp.add_parser("set", help="Set top directory")
    ap_setd.add_argument("directory", help="Directory to set", type=Path)
    ap_setd.add_argument(
        "-i",
        "--index",
        help="Set some other directory index",
        default=-1,
        type=int,
    )
    ap_setd.set_defaults(func=setd)

    ap_popd = subp.add_parser("pop", help="Pop directory from the wdh stack")
    ap_popd.add_argument(
        "-i",
        "--index",
        help="Pop some other directory index",
        default=-1,
        type=int,
    )
    ap_popd.set_defaults(func=popd)
    options, _ = ap.parse_known_args(args)
    options.func(**options.__dict__)


if __name__ == "__main__":
    main(sys.argv[1:])
