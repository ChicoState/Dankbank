#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (C) 2018 Elvis Yu-Jing Lin <elvisyjlin@gmail.com>
# Licensed under the MIT License - https://opensource.org/licenses/MIT

import argparse
import json
import os
import requests
import shutil
import time
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
##adding imports for text reader and
from PIL import Image
import pytesseract
import sys
import re
import mysql.connect


mydb = mysql.connector.connect(
    host=sys.argv[4],
    user=sys.argv[5],
    passwd=sys.argv[6],
    database=sys.argv[7]
)

mycursor = mydb.cursor()

class Downloader():
    def __init__(self):
        self.description = 'Downloader'
        self.identifier = 'download'
        self.keyword = 'url'
        self.credentials = {}
        self.save_path = '.'
        self.sess = requests.Session()

    def parse(self, args=None):
        parser = argparse.ArgumentParser(description=self.description)
        parser.add_argument('keywords', nargs='*', help=self.keyword+'s to crawl (or files containing '+self.keyword+'s)')
        parser.add_argument('-c', '--credential_file', type=str, help='credential filename')
        parser.add_argument('-s', '--save_path', type=str, help='path to save')
        parser.add_argument('-e', '--early_stop', action='store_true')
        return parser.parse_args(args=args)

    def crawl(self, keyword, early_stop):
        pass

    def login(self, username, password):
        pass

    def download(self, img_url, filename, headers={}):
        if os.path.exists(filename):
            print('File exists ({}). Skip {}'.format(filename, img_url))
            return False
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        # print('Downloading {} as {}'.format(img_url, filename))
        res = self.sess.get(img_url, stream=True, timeout=10, verify=False, headers=headers)
        if res.status_code == 200:
            with open(filename, 'wb') as f:
                shutil.copyfileobj(res.raw, f)
            fn = re.search("[^/]+$",filename)
            txt = pytesseract.image_to_string(Image.open(fn.string))
            if txt != "": #read text from image, if not empty string add to database
                if sys.argv[2] == "instagram":
                    sql = "INSERT INTO instagram_images (username,url,text) VALUES (%s,%s,%s)"
                if sys.argv[2] == "reddit":
                    sql = "INSERT INTO reddit_images (subreddit,url,text) VALUES (%s,%s,%s)"
                val = (sys.argv[3], img_url, txt)
                mycursor.execute(sql,val)
                mydb.commit()
            os.remove(fn.string)
            del res
        else:
            print('Filename:', filename)
            print('Headers:', headers)
            raise Exception('Response status code: {:d}. {:s}'.format(res.status_code, img_url))
        return True

    def run(self, args=None):
        args = self.parse(args)
        print(args)

        if args.save_path is not None:
            self.save_path = args.save_path

        if args.credential_file is not None and os.path.exists(args.credential_file):
            self.credentials = json.load(open(args.credential_file, 'r', encoding='utf-8'))

        if self.identifier in self.credentials:
            username = self.credentials[self.identifier]['username']
            password = self.credentials[self.identifier]['password']
            if username is not None and password is not None and \
               username != '' and password != '':
                self.login(username, password)

        for keyword in args.keywords:
            if keyword.endswith('.txt') and os.path.exists(keyword):
                with open(keyword, 'r') as f:
                    kws = [kw.strip() for kw in f.read().split() if not kw.startswith('#')]
                    print('In file', keyword, 'finds {}s:'.format(self.keyword), kws)
                    for kw in kws:
                        self.crawl(kw, args.early_stop)
            else:
                self.crawl(keyword, args.early_stop)

if __name__ == '__main__':
    pass
