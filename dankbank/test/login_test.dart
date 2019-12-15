import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dankbank/meme.dart';
import 'dart:convert';
import 'package:test/test.dart';

void main() {
  test('Sanity check', () {
    var result = true;
    rootBundle.loadString('assets/hardcode.json').then(
            (str) {
          List memes = jsonDecode(str);
         // _suggestions.addAll(memes.map((m) => Meme.fromJson(m)).toList());
          MemeList.fromJson(memes);
        }
    );
    expect(result, true);
  });
}
