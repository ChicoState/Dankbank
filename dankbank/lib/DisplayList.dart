import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meme.dart';


final _saved = Set<Meme>();

Future<MemeList> fetchMemes({String search:""}) async {
  try {
    final response = await http.get('http://35.209.126.69/'
        + search == "" ? 'json' : search);

    if (response.statusCode == 200) {
      return MemeList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load memes');
    }
  } catch(e) {
    final response = await rootBundle.loadString('assets/hardcode.json');
    return MemeList.fromJson(json.decode(response));
  }
}

class DisplayList extends StatefulWidget {
  const DisplayList({Key key, this.search}): super(key: key);

  final String search;

  @override
  DisplayListState createState() {
    return DisplayListState();
  }
}

class DisplayListState extends State<DisplayList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<MemeList>(
          future: fetchMemes(search:widget.search),
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
                    trailing: Icon(
                      _saved.contains(myMemes[index])? Icons.favorite : Icons.favorite_border,
                      color: _saved.contains(myMemes[index])? Colors.red : null,
                    ),
                    onTap: () {
                      setState(() {
                        if (_saved.contains(myMemes[index])) {
                          _saved.remove(myMemes[index]);
                        } else {
                          _saved.add(myMemes[index]);
                        }
                      });
                    }
                  );
                }
              );
            } else if (snapshot.hasError) {
              return Text("$snapshot.error");
            }
            return CircularProgressIndicator();
          },
        )
      )
    );
  }

}

Save() {
  return _saved;
}