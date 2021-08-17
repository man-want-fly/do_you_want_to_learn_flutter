import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'extensions/string_extension.dart';

class WidgetsPage extends StatelessWidget {

  final List<_Widgets> _widgets = _Widgets.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widgets')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(describeEnum(_widgets[index]).toString().capitalize()),
            onTap: () {
              print('cell tapped');
            }
          );
        },
        separatorBuilder: (_, index) => Divider(color: Colors.blue),
        itemCount: _widgets.length
      )
    );
  }
}

enum _Widgets {
  text, button, image, icon, 
  textField, form, textFormField, 
  theSwitch, checkbox, radio, 
  container, padding, align, row, column
}