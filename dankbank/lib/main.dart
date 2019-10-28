// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'meme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  //_SearchBar createState() => _SearchBar();
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: MemeList(),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FloatingSearchBar.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        trailing: CircleAvatar(
          child: Text("RD"),
        ),
/*        drawer: Drawer(
          child: Container(),
        ), */
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
        ),
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
        (str) async {
          List memes = jsonDecode(str);
           // _suggestions.clear();
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
      bottomNavigationBar: BottomAppBar(
        //child: SearchBar(),
          child: IconButton(icon: Icon(Icons.search), onPressed: _SearchBar),
      ),
    );
  }

  void _SearchBar() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                body: SearchBar(),
              );
            })
    );
  }

  final _suggestions = <Meme>[];
  final _saved = Set<Meme>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        itemCount: _suggestions.length,
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
      title: CachedNetworkImage(
        imageUrl: meme.url,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
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
                title: CachedNetworkImage(
                  imageUrl: meme.url,
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
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