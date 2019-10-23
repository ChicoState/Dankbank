// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'meme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

Future<MemeList> fetchMemes() async {
  final response = await http.get('http://35.209.126.69/json');

  if (response.statusCode == 200) {
    return MemeList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load memes');
  }
//  final response = await http.get('https://jsonplaceholder.typicode.com/posts');
//  if (response.statusCode == 200) {
//    return jsonDecode(response.body).map((m) => TestPost.fromJson(m)).toList();
//  } else {
//    throw Exception('Failed to load test post');
//  }
}

void main() => runApp(MyApp(memes: fetchMemes()));

class MyApp extends StatelessWidget {
  final Future<MemeList> memes;

  MyApp({Key key, this.memes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dankbank',
      theme: ThemeData(
        primaryColor: Colors.purple[900],
        canvasColor: Colors.purple[100],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('The Vault'),
        ),
        body: Center(
          child: FutureBuilder<MemeList>(
            future: memes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List <Meme> myMemes = snapshot.data.memes;
                return ListView.builder(
                  itemCount: myMemes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: CachedNetworkImage(
                        imageUrl:myMemes[index].url,
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    );
                  }
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
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
//FutureBuilder<MemeList>(
//  future: fetchMemes(),
//  builder: (context, snapshot) {
//    if (snapshot.hasdata) {
//
//    }
//  }
//);
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