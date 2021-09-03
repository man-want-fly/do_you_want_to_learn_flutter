import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';
import 'widget_draggable_scrollable_sheet.dart';
import 'widget_grid.dart';

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
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () => _onTapListItem(context, _elements[i])
        ),
        separatorBuilder: (_, x) => Divider(),
        itemCount: _elements.length
      ),
    );
  }

  void _onTapListItem(BuildContext context, _WidgetsScrollingElement element) {
    switch (element) {
      case _WidgetsScrollingElement.draggableScrollableSheet:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => WidgetDraggableScrollableSheet(title: element.title))
        );
        break;

      case _WidgetsScrollingElement.gridView:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => WidgetGridView(title: element.title))
        );
        break;

      default:
        break;
    }
  }
}

enum _WidgetsScrollingElement {
  draggableScrollableSheet, gridView, nestedScrollView
}

extension _WidgetsScrollingElementExtension on _WidgetsScrollingElement {
  String get title => describeEnum(this).capitalize();
}