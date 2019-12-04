import 'dart:async';

import 'package:flutter/material.dart';
import 'DisplayList.dart';
import 'meme.dart';
import 'Search.dart';
import 'Favorites.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  final FirebaseApp app;

  Home({this.app});

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  MemeList _theMemes;
  DatabaseReference _dankbase;
  StreamSubscription<Event> _memeSubscription;
  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _dankbase = database.reference().child('memes');
    _dankbase.child('reddit').once().then((DataSnapshot snapshot) {
      print('Connected to reddit database and read ${snapshot.value}');
      setState(() {
        _error = null;
        _theMemes = MemeList.fromJson(snapshot.value) ?? 0;
      });
    });
//    database.setPersistenceEnabled(true);
//    database.setPersistenceCacheSizeBytes(100000000);
//    _dankbase.keepSynced(true);
//    _memeSubscription = _dankbase.limitToLast(10).onChildAdded.listen((Event event) {
//      print('Data added: ${event.snapshot.value}');
//      setState(() {
//        _error = null;
//        _theMemes = MemeList.fromJson(event.snapshot.value) ?? 0;
//      });
//    }, onError: (Object o) {
//      final DatabaseError error = o;
//      print('Error: ${error.code} ${error.message}');
//      setState(() {
//        _error = error;
//      });
//    });
  }

  @override
  void dispose() {
    super.dispose();
    _memeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Vault'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favorites()),
                );
              }
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              }
          ),
        ]
      ),
      body: DisplayList(memes: _theMemes),
    );
  }
}