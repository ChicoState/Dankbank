// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'meme.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MemeList(),
    );
  }
}

class MemeList extends StatefulWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      // children: MemeCardList
    );
  }

  @override
  MemeListState createState() => MemeListState();
}

class MemeListState extends State<MemeList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memes'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildMemeList(),
    );
  }

  final _testJson = "";
  final _memes = <Meme>[];
  final _favorites = Set<Meme>();
  final _biggerFont = const TextStyle(fontSize: 16.0);

  Widget _buildMemeList() {

    // TODO: turn the json into a list of memes

    final Iterable<ListTile> tiles =_memes.map(
      (Meme meme) {
        return ListTile(
          title : Text(
            meme.url,
            style: _biggerFont,
          ),
        );
      }
    );

    final List<ListTile> memes = ListTile
      .divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

    return ListView(children : memes);
  }

  Widget _buildRow(WordPair pair) {
    // TODO: Get more results from the database to expand the list?
//    final bool alreadySaved = _favorites.contains(pair);
//    return ListTile(
//      title: Text(
//        pair.asPascalCase,
//        style: _biggerFont,
//      ),
//      trailing: Icon(
//        alreadySaved? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved? Colors.red : null,
//      ),
//      onTap: () {
//        setState(() {
//          if (alreadySaved) {
//            _favorites.remove(pair);
//          } else {
//            _favorites.add(pair);
//          }
//        });
//      },
//    );
  }

  void _pushEnlarge() {

  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _favorites.map(
              (Meme pair) {
                return ListTile(
                  title: Text(
                    pair.url,
                    style: _biggerFont,
                  ),
                );
              },
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions')
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}