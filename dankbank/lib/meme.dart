import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable(explicitToJson: true)
class Meme {

  Meme({this.username, this.url, this.text});

  final String username;
  final String url;
  final String text;

  factory Meme.fromJson(Map<String, dynamic> json) {
    return new Meme(
      username: json['username'],
      url: json['url'],
      text: json['text']
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'username': username,
      'url': url,
      'text': text,
    };
}

//@JsonSerializable(explicitToJson: true)
class MemeList {

  final List<Meme> memes;
  MemeList({
    this.memes,
  });

  factory MemeList.fromJson(List<dynamic> parsedJson) {
    List<Meme> memes = new List<Meme>();
    memes = parsedJson.map((m)=>Meme.fromJson(m)).toList();
    return new MemeList(memes: memes);
  }
}

// TODO: Remove this function.
// Perhaps we can use similar functionality to download/process data as needed
Iterable<Meme> generateTestMemes() sync* {
  final meme = Meme(username:'a', url:'example.com', text:'c');
  for (;;) {
    yield meme;
  }
}

class TestPost {
  TestPost(this.userId, this.id, this.title, this.body);

  final int userId;
  final int id;
  final String title;
  final String body;

  TestPost.fromJson(Map<String, dynamic> json) :
        userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];
}
