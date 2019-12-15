import 'package:dankbank/meme.dart';
import 'package:test/test.dart';

void main() {
  /*
  test('Check toJson in MemeList', () {
    Meme m1 = Meme(username: 'bobby',url: 'www.google.com',text: 'Can we all just get A\'s?');
    expect(m1.toJson(), '{username: bobby, url: www.google.com, text: Can we all just get A\'s?}');
  });
   */
  test('Check hasData variable in MemeList Data', () {
    Meme m1 = Meme(username: 'a',url: 'a',text: 'a');
    Meme m2 = Meme(username: 'a',url: 'a',text: 'a');
    List memes = [m1.toJson(),m2.toJson()];
    MemeList a = MemeList.fromJson(memes);
    expect(a.hasData, true);
  });
  test('Check hasData variable in MemeList No Data', () {
    List memes = [];
    MemeList a = MemeList.fromJson(memes);
    expect(a.hasData, false);
  });
  test('Check fromJson checks null parameter', () {
    List memes = null;
    expect(MemeList.fromJson(memes), null);
  });
  test('Check fromJson parsing in MemeList', () {
    Meme m1 = Meme(username: 'bobby',url: 'www.google.com',text: 'Can we all just get A\'s?');
    Meme m2 = Meme(username: 'jimbo',url: 'www.google.com',text: 'Epstein didn\'t kill himself');
    Meme m3 = Meme(username: 'gus',url: 'www.google.com',text: 'Milk.');
    List memes = [m1.toJson(),m2.toJson(),m3.toJson()];
    MemeList a = MemeList.fromJson(memes);
    expect(a.memes[1].text, 'Epstein didn\'t kill himself');
  });
}
