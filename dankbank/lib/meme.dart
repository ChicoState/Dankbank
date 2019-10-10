class Meme {

  final String username;
  final String url;
  final String text;

  Meme(this.username, this.url, this.text);

  Meme.fromJson(Map<String, dynamic> json)
      :
        username = json['username'],
        url = json['url'],
        text = json['text'];

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'url': url,
        'text': text,
      };
}

// TODO: Remove this function.
// Perhaps we can use similar functionality to download/process data as needed
Iterable<Meme> generateTestMemes() sync* {
  final meme = Meme('a', 'b', 'c');
  for (;;) {
    yield meme;
  }
}
