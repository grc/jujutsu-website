#!/usr/bin/env python3

from ftplib import FTP_TLS
import fnmatch
import os
import secrets

def main():
    ftp = connect()
    upload_directory(ftp, "/Users/grc/Sites/jujutsu")

def connect():
    ftp = FTP_TLS(secrets.server(), secrets.user(), secrets.password())
    return ftp





def upload_directory(ftp, directory):
    ds = [entry for entry in os.scandir(directory) if entry.is_dir()]
    for d in ds:
        if is_interesting_dir(d):
            upload_directory(ftp, d.path)
        
    change_to_directory(ftp, directory, "/Users/grc/Sites/jujutsu")
    fs = [entry for entry in os.scandir(directory) if entry.is_file()]
    for f in fs:
        if is_interesting_file(f):
            upload_file(ftp, f.path)

def change_to_directory(ftp, directory, root):
    """directory is the absolute local path, root the local site root"""
    reldir = os.path.relpath(directory, root)
    absdir = os.path.normpath("/" + reldir)
    log("Changing remote directory to " + absdir)
    ftp.cwd(absdir)

def is_interesting_file(fn):
    boring_files = ["*.DS_Store", "*.original"]
    for boring in boring_files:
        if fnmatch.fnmatch(fn, boring):
            return False
    return True

def is_interesting_dir(d):
    boring_dirs = ["*.bak", "*.git"]
    for boring in boring_dirs:
        if fnmatch.fnmatch(d, boring):
            return False
    return True

def upload_file(ftp, f):
    log("Uploading " + f)
    with open(f, 'rb') as fp:
        ftp.storbinary("STOR " + os.path.basename(f), fp)
    log("Done")
    
def log(s):
    print(s)




if __name__ == '__main__':
    main()
