import 'package:flutter/material.dart';
import 'DisplayList.dart';
import 'Search.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Vault'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
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
      body: DisplayList(),
    );
  }
}