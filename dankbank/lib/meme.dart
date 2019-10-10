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
