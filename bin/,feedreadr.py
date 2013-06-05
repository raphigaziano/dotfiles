#! /usr/bin/python
r"""
Simple feed reader.

Should handle both rss and atom feeds.

Dependencies:
    - requests
    - feedparser
    - argparse (included in python > 2.7)

There's probably a lot of scripts that out there already that can handle
the job much better, but who cares, reinventing the wheel is fun \o/

Left todo: better error handling

author: raphi <r.gaziano@gmail.com>
created: 2013-06-02
"""
from __future__ import print_function, unicode_literals

import sys
import os
import json
from getpass import getpass

# Prevent encoding troubles when piping output,
# ie make sure sys.stdout is utf8
if sys.stdout.encoding is None:
    import codecs
    writer = codecs.getwriter('utf-8')
    sys.stdout = writer(sys.stdout)

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

DEFAULT_TMPL = "{title}\n  {link}"

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

def print_entries(feed, tmpl=DEFAULT_TMPL):
    """ 
    Print out the passed feed, according to the template tmpl.
    tmpl should be a string containing new style (ie {}) format tags,
    names after fields available on a feedparser's feed entry
    (See DEFAULT_TMPL for an exemple).
    """
    tmpl = tmpl.replace('{', '{0.')
    # Shell can't pass escape characters, sends literals instead...
    tmpl = tmpl.replace('\\n', '\n') # TODO: better subst
    print("%s\n" % feed.feed.title);
    if not feed.entries:
        print("No entry")
    for i, e in enumerate(feed.entries):
        e.n = i
        print(tmpl.format(e))     # TODO: add n to def tmpl and DOC IT

FEEDS_FILE = os.path.join(os.path.dirname(__file__), '.feeds')
if not os.path.exists(FEEDS_FILE):
    f = open(FEEDS_FILE, 'w')
    f.write('{}')
    f.close()
    
with open(FEEDS_FILE, 'r') as f:
    FEEDS = json.load(f)


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
    tmpl    = args.template

    if url in FEEDS:
        # Keep assignments in that order to avoid using the actual
        # url as a key
        usrname = FEEDS[url].get('user', '')
        tmpl    = tmpl or FEEDS[url].get('template', '')
        url     = FEEDS[url]['url']

    if usrname:
        pswd = getpass('Host password for user %s: ' % usrname)
    else:
        pswd = ""

    print("Retrieving feed from %s..." % (url))
    try:
        feed = parse(url, usrname, pswd)
    except requests.RequestException as e:
        print("Error: %s" % e)
        return 1
    print()
    try:
        print_entries(feed, tmpl or DEFAULT_TMPL)
    except AttributeError as e:
        print("Error: %s" % e)
        return 1

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
    }
    if args.user:
        new_feed['user']     = args.user
    if args.template:
        new_feed['template'] = args.template

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
    subparsers = arg_parser.add_subparsers(
        title='subcommands',
        help='Type ,feedreadr <subcommand> -h for more detailed help'
    )

    fetch_parser = subparsers.add_parser('fetch',
            help="Read a feed.")
    fetch_parser.add_argument('-u', '--user',  action='store',
            help='User name - for feeds requiring authentication.'
                 'If provided, you will be prompted for a password. '
                 'Leave it blank if this is not needed')
    fetch_parser.add_argument('-t', '--template', action='store',
            help="Custom template for feed printing. This should be a string, "
                 "enclosed in \"double quotes\", and containing valid tag "
                 "names from the requested feed enclosed in curly brackets. "
                 "Default is \"{title}\n  {link}\".")
    fetch_parser.add_argument('feed',
            help='feed to parse. Can be either a valid url, or the name of '
                 'a registered feed.')
    fetch_parser.set_defaults(func=fetch_feed)

    list_parser = subparsers.add_parser('list',
            help="List registered feeds.")
    list_parser.set_defaults(func=list_feeds)
    
    reg_parser  = subparsers.add_parser('register',
            help="Register a new feed.")
    reg_parser.add_argument('feedname', 
            help="Name of the feed to be registered. Will be used for all "
                 "future references to that partocular feed.")
    reg_parser.add_argument('feedurl',
            help="Feed url.")
    reg_parser.add_argument('-u', '--user', action='store',
            help="Optional user name the feed will be associated with. "
                 "Provide it is authentication is required.")
    reg_parser.add_argument('-t', '--template', action='store',
            help="Optional template string for displaying the feed.")
    reg_parser.set_defaults(func=register_feed)
    
    del_parser  = subparsers.add_parser('remove',
            help="Delete a registered feed.")
    del_parser.add_argument('feed',
            help="Name of the feed to delete.")
    del_parser.set_defaults(func=del_feed)

    args = arg_parser.parse_args()
    args.func(args)
