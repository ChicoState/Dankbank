import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'DisplayList.dart';
import 'meme.dart';
import 'BottomAppBar.dart';

class Favorites extends StatefulWidget {
  @override
  FavoritesState createState() {
    return FavoritesState();
  }
}

class FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = Save().map<ListTile>(
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
            title: Text('Favorites')
        ),
        body: ListView(children: divided),
      bottomNavigationBar: BottomBar(),
    );
  }
}