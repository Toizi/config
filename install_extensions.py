#!/usr/bin/env python3

import subprocess

def main():
    with open("vscode_extensions.txt", "r") as f:
        new_exts = f.readlines()
    new_exts = set((ext.strip() for ext in new_exts))
    
    installed_exts = subprocess.check_output(['code', '--list-extensions'])
    installed_exts = installed_exts.decode().splitlines()
    installed_exts = set((ext.strip() for ext in installed_exts))

    to_install_exts = new_exts - installed_exts
    for ext in to_install_exts:
        subprocess.check_call(['code', '--install-extension', ext])
    if not to_install_exts:
        print('no extensions to install')

if __name__ == '__main__':
    main()
