// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'meme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
  MemeListState createState() => MemeListState();
}


class MemeListState extends State<MemeList> {

  @override
  Widget build(BuildContext context) {
    rootBundle.loadString('assets/hardcode.json').then(
        (str) {
          List memes = jsonDecode(str);
          _suggestions.addAll(memes.map((m) => Meme.fromJson(m)).toList());
        }
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('The Vault'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  final _suggestions = <Meme>[];
  final _saved = Set<Meme>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i < _suggestions.length) {
            if (i.isOdd) return Divider();

            final index = i ~/ 2;
            //          if (index >= _suggestions.length) {
            //            _suggestions.addAll(generateTestMemes().take(10));
            //          }
            return _buildRow(_suggestions[index]);
          }
          return _buildRow(generateTestMemes().first);
        }
    );
  }

  Widget _buildRow(Meme meme) {
    final bool alreadySaved = _saved.contains(meme);
    return ListTile(
      title: Text(
        meme.url,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(meme);
          } else {
            _saved.add(meme);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (Meme meme) {
              return ListTile(
                title: Text(
                  meme.url,
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