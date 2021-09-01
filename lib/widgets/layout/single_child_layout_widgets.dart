import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'elements/widget_transform_3d.dart';
import '/extensions/string_extension.dart';


class SingleLayoutWidgets extends StatelessWidget {
  const SingleLayoutWidgets({Key? key}) : super(key: key);

  final _elements = _SingleChildLayoutWidgetsElement.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Single child layout widgets')),
      body: ListView.separated(
        itemBuilder: (_, index) {
          final ele = _elements[index]; 
          return ListTile(
            title: Text(ele.title), 
            onTap: () => _onTapListItem(context, ele)
          );
        },
        separatorBuilder: (_, index) => Divider(), 
        itemCount: _elements.length
      )
    );
  }

  void _onTapListItem(BuildContext context, _SingleChildLayoutWidgetsElement element) {
    switch (element) {
      case _SingleChildLayoutWidgetsElement.transform3d:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => WidgetTransform3D(title: element.title))
        );
        break;
      default:
        break;
    }
  }
}

enum _SingleChildLayoutWidgetsElement { transform3d }

extension _SingleChildLayoutWidgetsElementExtension on _SingleChildLayoutWidgetsElement {
  String get title {
    return describeEnum(this).capitalize();
  }
}