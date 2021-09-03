import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';

class WidgetsScrolling extends StatelessWidget {
  const WidgetsScrolling({ Key? key, required this.title }) : super(key: key);

  final String title;

  final _elements = _WidgetsScrollingElement.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemBuilder: (_, i) => ListTile(
          title: Text(_elements[i].title),
          trailing: Icon(Icons.arrow_forward_ios_rounded)
        ), 
        separatorBuilder: (_, x) => Divider(), 
        itemCount: _elements.length
      ),
    );
  }
}

enum _WidgetsScrollingElement {
  draggableScrollableSheet, gridView, nestedScrollView
}

extension _WidgetsScrollingElementExtension on _WidgetsScrollingElement {
  String get title => describeEnum(this).capitalize();
}