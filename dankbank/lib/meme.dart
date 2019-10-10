import 'package:json_annotation/json_annotation.dart';

part 'meme.g.dart';

@JsonSerializable(explicitToJson: true)
class Meme {

  Meme(this.username, this.url, this.text);

  final String username;
  final String url;
  final String text;

  factory Meme.fromJson(Map<String, dynamic> json) => _$MemeFromJson(json);

  Map<String, dynamic> toJson() => _$MemeToJson(this);
}

@JsonSerializable()
class MemeList {

  MemeList(this.memes);

  final Map<String, dynamic> memes;

  factory MemeList.fromJson(Map<String, dynamic> json) => _$MemeListFromJson(json);

  Map<String, dynamic> toJson() => _$MemeListToJson(this);
}

// TODO: Remove this function.
// Perhaps we can use similar functionality to download/process data as needed
Iterable<Meme> generateTestMemes() sync* {
  final meme = Meme('a', 'b', 'c');
  for (;;) {
    yield meme;
  }
}
