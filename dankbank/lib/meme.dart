class Meme {

  Meme({this.username, this.url, this.text});

  final String username;
  final String url;
  final String text;

  factory Meme.fromJson(Map<dynamic, dynamic> json) {
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

class MemeList {

  final List<Meme> memes;
  final bool hasData;
  final bool hasError;

  MemeList({
    this.memes,
    this.hasData,
    this.hasError,
  });

  factory MemeList.fromJson(List<dynamic> parsedJson) {
    if (parsedJson == null) {
      return null;
    }
    List<Meme> memes = new List<Meme>();
    memes = parsedJson.map((m)=>Meme.fromJson(m)).toList();
    bool hasData = memes.length > 0;
    bool hasError = false;
    return new MemeList(memes: memes, hasData: hasData, hasError: hasError);
  }
}

//class TestPost {
//  TestPost(this.userId, this.id, this.title, this.body);
//
//  final int userId;
//  final int id;
//  final String title;
//  final String body;
//
//  TestPost.fromJson(Map<String, dynamic> json) :
//        userId = json['userId'],
//        id = json['id'],
//        title = json['title'],
//        body = json['body'];
//}
