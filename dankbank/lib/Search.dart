import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'BottomAppBar.dart';
import 'meme.dart';
import 'DisplayList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Search extends StatefulWidget {

  final FirebaseApp app;

  Search({this.app});

  @override
  SearchState createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  MemeList _theMemes;
  DatabaseReference _dankbase;
  StreamSubscription<Event> _memeSubscription;
  DatabaseError _error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar.builder(
        itemCount: 1,//_theMemes.memes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },

        onChanged: (String value) {
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
           };
          },
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}