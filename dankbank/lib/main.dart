// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'meme.dart';
import 'Home.dart';
import 'DisplayList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'memes',
    options: const FirebaseOptions(
      googleAppID: '1:994973522467:android:9c488ff3baadefe06fef96',
      apiKey: 'AIzaSyA0uSzPacdqMT9Trc2rByLoPOA7Oz6vVHo',
      databaseURL: 'https://ceremonial-team-229918.firebaseio.com/'
    ),
  );
  runApp(MyApp(
      memes: fetchMemes(),
      app: app
  ));
}

class MyApp extends StatelessWidget {
  final Future<MemeList> memes;
  final FirebaseApp app;

  MyApp({Key key, this.memes, this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dankbank',
      theme: ThemeData(
        primaryColor: Colors.purple[900],
        canvasColor: Colors.purple[100],
      ),
      home: Home(app: app),
    );
  }
}

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Startup Name Generator',
//      theme: ThemeData(
//        primaryColor: Colors.white,
//      ),
//      home: MemeList(),
//    );
//  }
//}
//
//Future<MemeList> fetchMemes() async {
//  final response = await rootBundle.loadString('assets/hardcode.json');
//  return jsonDecode(response).map((m)=>Meme.fromJson(m)).toList();
//}
//
//class MemeList extends StatefulWidget {
//  @override
//  MemeListState createState() {
//    rootBundle.loadString('assets/hardcode.json').then((str) {
//      List memes = jsonDecode(str);
//
//    })
//    return MemeListState();
//  }
//}
//
//class MemeListState extends State<MemeList> {
//
//  @override
//  Widget build(BuildContext context) {
//    rootBundle.loadString('assets/hardcode.json').then(
//        (str) {
//          List memes = jsonDecode(str);
//          setState(() {
//            this._suggestions = memes.map((m) => Meme.fromJson(m)).toList();
//          });
//        }
//    );
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('The Vault'),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//
//  final _suggestions = <Meme>[];
//  final _saved = Set<Meme>();
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//
//  Widget _buildSuggestions() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemCount: _suggestions.length,
//        itemBuilder: (context, i) {
////          if (i < _suggestions.length) {
//            if (i.isOdd) return Divider();
//
//            final index = i ~/ 2;
//            //          if (index >= _suggestions.length) {
//            //            _suggestions.addAll(generateTestMemes().take(10));
//            //          }
//            return _buildRow(_suggestions[index]);
////          }
////          return _buildRow(generateTestMemes().first);
//        }
//    );
//  }
//
//  Widget _buildRow(Meme meme) {
//    final bool alreadySaved = _saved.contains(meme);
//    return ListTile(
//      title: CachedNetworkImage(
//        imageUrl: meme.url,
//        placeholder: (context, url) => new CircularProgressIndicator(),
//        errorWidget: (context, url, error) => new Icon(Icons.error),
//      ),
//      trailing: Icon(
//        alreadySaved? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved? Colors.red : null,
//      ),
//      onTap: () {
//        setState(() {
//          if (alreadySaved) {
//            _saved.remove(meme);
//          } else {
//            _saved.add(meme);
//          }
//        });
//      },
//    );
//  }
//
//  void _pushSaved() {
//    Navigator.of(context).push(
//      MaterialPageRoute<void>(
//        builder: (BuildContext context) {
//          final Iterable<ListTile> tiles = _saved.map(
//                (Meme meme) {
//              return ListTile(
//                title: Text(
//                  meme.url,
//                  style: _biggerFont,
//                ),
//              );
//            },
//          );
//          final List<Widget> divided = ListTile
//              .divideTiles(
//            context: context,
//            tiles: tiles,
//          )
//              .toList();
//
//          return Scaffold(
//            appBar: AppBar(
//                title: Text('Saved Suggestions')
//            ),
//            body: ListView(children: divided),
//          );
//        },
//      ),
//    );
//  }
//}