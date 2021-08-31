import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';
import 'basic_widget_element.dart';
import 'basic_widget_wrapper.dart';

class BasicWidgetsPage extends StatelessWidget {

  final List<BasicWidgetElement> _elements = BasicWidgetElement.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widgets')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          BasicWidgetElement element = _elements[index];
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