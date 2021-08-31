import 'dart:math';

import 'package:flutter/material.dart';

class WidgetTransform extends StatelessWidget {
  const WidgetTransform({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.black,
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0.3)..rotateZ(-pi / 12.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFFE8581C),
            child: const Text('Apartment for rent!'),
          )
        )
      )
    );
  }
}
