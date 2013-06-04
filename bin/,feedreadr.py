#! /usr/bin/python
"""
Simple feed reader.

Should handle both rss and atom feeds.

Dependencies:
    - requests
    - feedparser
    - argparse (included in python > 2.7)

There's probably a lot of scripts that out there already that can handle
the job much better, but who cares, reinventing the wheel is fun \o/

author: raphi <r.gaziano@gmail.com>
created: 2013-06-02
"""
from __future__ import print_function, unicode_literals

import sys
import os
import json
from getpass import getpass

try:
    import requests
except ImportError:
    print("This script depends on the requests library.")
    sys.exit(1)
try:
    import feedparser
except ImportError:
    print("This script depends on the feedparser library.")
    sys.exit(1)


def parse(url="", username="", pswd=""):
    """
    Get the feed from url and return a parsed tree of it.
    username & pswd will be used for authentication if provided.
    Only handle getting feeds from http(s) for now.
    """
    r = requests.get(url, auth=(username, pswd))
    if r.status_code != 200:
        r.raise_for_status()
    return feedparser.parse(r.text)

def _default_printer(feed):
    """ Basic feed printing. """
    # TODO: prettier print output
    print(feed.feed.title)
    if not feed.entries:
        print("No entry")
    for e in feed.entries:
        print("%s\n<%s>" % (e.title, e.link))

def print_entries(feed, printer=_default_printer):
    """
    Top level feed printer. Pass it a printer callback for custom output. 
    Custom printers should accept a feed argument and are responsible for 
    picking what should be diplayed.
    """
    return printer(feed)


FEEDS_FILE = os.path.join(os.path.dirname(__file__), '.feeds')
if not os.path.exists(FEEDS_FILE):
    f = open(FEEDS_FILE, 'w')
    f.write('{}')
    f.close()
    
with open(FEEDS_FILE, 'r') as f:
    FEEDS = json.load(f)

FEEDS_NAMES = [fn for fn in FEEDS]

def fetch_feed(args):
    """ 
    Fetch the feed provided in args and displays it.
    Mapped to the "fetch" command when used as a standalone script.
    args should contain:
        - feed:     The name or url of the feed to be fetched.
        - user:     a user name (will prompt for a password if present). 
                    (optional)
    """
    url     = args.feed
    usrname = args.user

    if url in FEEDS:
        # Keep assignments in that order to avoid using the actual
        # url as a key
        usrname = FEEDS[url]['user']
        url     = FEEDS[url]['url']

    if usrname:
        pswd = getpass('Host password for user %s: ' % usrname)
    else:
        pswd = ""

    feed = parse(url, usrname, pswd)
    print_entries(feed)

    return 0

def get_feeds_list():
    """ Return all currently registered feeds as a dictionnary. """
    return FEEDS

def write_feeds_list():
    """ Write the current feeds list to the json "db". """
    with open(FEEDS_FILE, 'w') as f:
        json.dump(FEEDS, f)

def list_feeds(args):
    """
    Print out a list of registered feeds.
    Mapped to the "list" command when used as a standalone script.
    """
    print(json.dumps(get_feeds_list(),
                     sort_keys=True,
                     indent=4, 
                     separators=(',', ':')
          )
    )
    return 0

def register_feed(args):
    """ 
    Store a new feed to the json "db".
    Mapped to the "register" command when used as a standalone script.
    args should contain:
        - feedname:     a name for the new feed.
        - feedurl:      the new feed's url.
        - user:         a user name to associate with the new feed (optional).
    """
    new_feed = {
        'url': args.feedurl,
        'user': args.user
    }
    FEEDS[args.feedname] = new_feed
    write_feeds_list()
    return 0

def del_feed(args):
    """ 
    Delete a feed from the json "db".
    Mapped to the "remove" command when used as a standalone script.
    args should contain:
        - feed:     the name of the feed to be removed.
    """
    del(FEEDS[args.feed])
    write_feeds_list()
    return 0
    
if __name__ == '__main__':

    import argparse
    arg_parser = argparse.ArgumentParser(prog=',feedreadr')
    subparsers = arg_parser.add_subparsers()

    fetch_parser = subparsers.add_parser('fetch')
    fetch_parser.add_argument('-u', '--user',  action='store',
            help='User name - for feeds requiring authentication.'
                 'If provided, you will be prompted for a password. '
                 'Leave it blank if this is not needed')
    fetch_parser.add_argument('feed', choices=FEEDS_NAMES,
            help='feed to parse. Can be either a valid url, or the name of '
                 'a registered feed.')
    fetch_parser.set_defaults(func=fetch_feed)

    # TODO: MOAR DOC
    
    list_parser = subparsers.add_parser('list')
    # arg_parser.add_argument('-l', '--list-feeds',  action='store_true',
    #         help='List registered feeds and exit.')
    list_parser.set_defaults(func=list_feeds)
    
    reg_parser  = subparsers.add_parser('register')
    reg_parser.add_argument('feedname', 
            help="popo")
    reg_parser.add_argument('feedurl',
            help="papa")
    reg_parser.add_argument('user', nargs='?',
            help="pupu")
    reg_parser.set_defaults(func=register_feed)
    
    del_parser  = subparsers.add_parser('remove')
    del_parser.add_argument('feed', choices=FEEDS_NAMES,
            help="pipi")
    del_parser.set_defaults(func=del_feed)

    args = arg_parser.parse_args()
    args.func(args)
