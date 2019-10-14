// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meme _$MemeFromJson(Map<String, dynamic> json) {
  return Meme(json['username'] as String, json['url'] as String,
      json['text'] as String);
}

Map<String, dynamic> _$MemeToJson(Meme instance) => <String, dynamic>{
      'username': instance.username,
      'url': instance.url,
      'text': instance.text
    };

MemeList _$MemeListFromJson(Map<String, dynamic> json) {
  return MemeList(json['memes'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MemeListToJson(MemeList instance) =>
    <String, dynamic>{'memes': instance.memes};
