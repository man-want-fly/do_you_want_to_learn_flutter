import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'extensions/string_extension.dart';
import 'widget_element.dart';
import 'widget_wrapper.dart';

class WidgetsPage extends StatelessWidget {

  final List<WidgetElement> _elements = WidgetElement.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widgets')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          WidgetElement element = _elements[index];
          String title = describeEnum(element).toString().capitalize();
          return ListTile(
            title: Text(title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WidgetWrapper(title: title, element: element)
                )
              );
            }
          );
        },
        separatorBuilder: (_, index) => Divider(color: Colors.blue),
        itemCount: _elements.length
      )
    );
  }
}