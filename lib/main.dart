import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

//void main() => runApp(MyApp());
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
////          child: new Text('Hello World...'),
////          child: new Text(wordPair.asPascalCase),
//          child: new RandomWords(),
//        ),
//      ),
      home: new RandomWords2(),

//      routes: <String, WidgetBuilder> {
//        '/a': (BuildContext context) => new MyPage(title: 'page A'),
//        '/b': (BuildContext context) => new MyPage(title: 'page B'),
//        '/c': (BuildContext context) => new MyPage(title: 'page C'),
//      },

    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }
}

class RandomWords2 extends StatefulWidget {
  @override
  createState() => new RandomWordsState2();
}

class RandomWordsState2 extends State<RandomWords2> {
  final _suggestions = <WordPair>[];
  final TextStyle _biggerFont =
      new TextStyle(fontSize: 12.0, color: new Color(0xFFFF1234));

  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //collections
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  //build body
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.lightBlue,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
