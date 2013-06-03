#! /usr/bin/python
"""
Simple feed reader.

Should handle both rss and atom feeds.

Dependencies:
    - requests
    - feedparser

Will hanlde registering feeds in a future version.

author: raphi <r.gaziano@gmail.com>
created: 2013-06-02
"""
from __future__ import print_function, unicode_literals

import sys
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

### TEMPO

KNOWN_HOSTS = {
    'sm': "http://sametmax.com/feed/"
}

###/TEMPO

def main(args):
    """ Script entry point. """
    url     = args.feed
    usrname = args.user

    url = KNOWN_HOSTS.get(url, url) # FIXME: read from file

    if usrname:
        pswd = getpass('Host password for user %s: ' % usrname)
    else:
        pswd = ""

    feed = parse(url, usrname, pswd)
    print_entries(feed)

    return 0
    
if __name__ == '__main__':

    import argparse
    arg_parser = argparse.ArgumentParser(prog='Feedreadr')
    arg_parser.add_argument('-u', '--user',  action='store',
            help='User name - for feeds requiring authentication.'
                 'If provided, you will be prompted or a password. '
                 'Leave it blank if this is not needed')
    arg_parser.add_argument('-l', '--list-feeds',  action='store_true',
            help='List registered feeds and exit.')
    # TODO: opt to register feed
    arg_parser.add_argument('feed', 
            help='feed to parse. Can be either a valid url, or the name of '
                 'a registered feed.')

    args = arg_parser.parse_args()
    sys.exit(main(args))
