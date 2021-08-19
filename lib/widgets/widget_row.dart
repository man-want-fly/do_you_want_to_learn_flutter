import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class WidgetRow extends StatefulWidget {
  const WidgetRow({Key? key}) : super(key: key);

  @override
  _WidgetRowState createState() => _WidgetRowState();
}

class _WidgetRowState extends State<WidgetRow> {

  String randomPair = '';
  String getRandomWordPair() => WordPair.random().asCamelCase;
  void changeWordPair() => setState(()  => randomPair =  getRandomWordPair());

  _WidgetRowState() {
    randomPair = getRandomWordPair();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterLogo(),
          )),
          Expanded(child: Text(randomPair)),
          Container(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(child: Text('change pair'), onPressed: changeWordPair),
          ),)
        ],
      ),
    );
  }
}
