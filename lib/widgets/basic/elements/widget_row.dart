import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class WidgetRow extends StatefulWidget {
  String? name;

  WidgetRow({Key? key, this.name}) : super(key: key);

  @override
  _WidgetRowState createState() => _WidgetRowState();
}

class _WidgetRowState extends State<WidgetRow> {
  String randomPair ='';

  String _getRandomWordPair() => WordPair.random().asCamelCase;

  void _changeWordPair() => setState(() => randomPair = _getRandomWordPair());

  @override
  void initState() {
    super.initState();
    randomPair = _getRandomWordPair();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterLogo(),
          )),
          Expanded(
              child: Text(
            randomPair,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  child: Text('change pair'), onPressed: _changeWordPair),
            ),
          )
        ],
      ),
    );
  }
}
