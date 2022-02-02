#
# Slightly modified version based on https://gist.github.com/tim-connolly/2db6d7fcdd7dc1cc589f66e06532de24
#

import os
import sys
import copy

def get_base_prefix_compat():
    """Get base/real prefix, or sys.prefix if there is none."""
    return (
        getattr(sys, "base_prefix", None)
        or getattr(sys, "real_prefix", None)
        or sys.prefix
    )


def in_virtualenv():
    return get_base_prefix_compat() != sys.prefix


def files_in_tree(dir):
    subfolders, files = [], []

    for f in os.scandir(dir):
        if f.is_dir():
            if '.tox' in str(f):
                continue
            subfolders.append(f.path)
        if f.is_file():
            files.append(f.path)

    for d in subfolders:
        f = files_in_tree(d)
        files.extend(f)
    return files


def print_all_files(dirs):
    files = []
    for d in dirs:
        if not os.path.isdir(d):
            continue
        dirpath = os.path.abspath(os.path.expanduser(d))
        f = files_in_tree(dirpath)
        files.extend(f)

    print("\n".join("{}".format(f) for f in files if f.endswith(".py")))
    with open('/home/tars/gutentags.log', 'a') as f:
       f.write("\n".join("{}".format(f) for f in files if f.endswith(".py")))


if in_virtualenv():
    sys_path = copy.copy(sys.path)
    sys_path.append('.')
    print_all_files(sys_path)
else:
    print_all_files(".")
