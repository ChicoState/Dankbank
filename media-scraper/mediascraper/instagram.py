#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (C) 2018 Elvis Yu-Jing Lin <elvisyjlin@gmail.com>
# Licensed under the MIT License - https://opensource.org/licenses/MIT

import os
import sys
import inspect
#current_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
#parent_dir = os.path.dirname(current_dir)
#sys.path.insert(0, parent_dir)
import mediascrapers


if __name__ == '__main__':
    scraper = mediascrapers.InstagramScraper(scroll_pause = 1.0, mode='normal', debug=False)
    if os.path.exists('credentials.json'):
        scraper.login('credentials.json')
    for username in sys.argv[1:]:
        tasks = scraper.scrape(username)
        scraper.download(tasks=tasks, path='download/')