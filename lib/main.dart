import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomeWidget(title: 'Do you want to learn Flutter?')
    );
  }
}
