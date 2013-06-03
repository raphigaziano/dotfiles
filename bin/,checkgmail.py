#! /usr/bin/python
"""
Quick wrapper around ,feedreadr.py to check for new mails in my
gmail box.

Depends on ,feedreadr, which itself depends on the request and feedparser 3rd
party libraries.

To check another mail account, either change the USER constant to this account's
url or pass it as a command line argument.

author: raphi <echo $USER>
created: 2013-06-03 Mon 19:24
"""
from getpass import getpass
import importlib

feedreadr = importlib.import_module(',feedreadr')

USER = 'r.gaziano@gmail.com'

def gmail_printer(feed):
    """ Custom printer for mailbox. """
    print(feed.feed.title)
    if not feed.entries:
        print("No new message.")
    for e in feed.entries:
        print("Subject: %s\t(from %s)" %
                (e.title, e.author.replace('(', '<').replace(')', '>'))
        )

if __name__ == '__main__':

    import sys

    if len(sys.argv) == 2:
        USER = sys.argv[1]

    pswd = getpass('Google mail password: ')
    feed = feedreadr.parse("https://mail.google.com/mail/feed/atom",
                           USER, pswd)
    feedreadr.print_entries(feed, gmail_printer)
