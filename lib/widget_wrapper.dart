import 'package:flutter/material.dart';

import 'widget_element.dart';
import 'widgets/widget_text.dart';
import 'widgets/widget_button.dart';
import 'widgets/widget_row.dart';

class WidgetWrapper extends StatelessWidget {
  WidgetWrapper({Key? key, required this.title, required this.element}) : super(key: key);

  final String title;
  final WidgetElement element;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)), 
      body: _buildBody(element)
    );
  }

  Widget _buildBody(WidgetElement element) {
    switch (element) {
      case WidgetElement.text:
        return WidgetText();
      case WidgetElement.button:
        return WidgetButton();
      case WidgetElement.row:
        return WidgetRow();
      default:
        return Text('Coming soon...');
    }
  }
}
