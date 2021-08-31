import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../placeholder.dart';
import '/widgets/basic/basic_widgets.dart';
import '/extensions/string_extension.dart';

class WidgetsCategories extends StatelessWidget {
  const WidgetsCategories({Key? key, required this.title}) : super(key: key);

  final String title;
  final _elements = _WidgetsCategoriesElement.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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

  void _onTapListItem(BuildContext context, _WidgetsCategoriesElement item) {
    switch (item) {
      case _WidgetsCategoriesElement.basic:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => BasicWidgetsPage(title: item.title))
        );
        break;
      default:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => PlaceholderWidget())
        );
        break;
    }
  }
}

enum _WidgetsCategoriesElement {
  basic,
  layout,
  scrolling // ...
}

extension _WidgetsCategoriesElementExtension on _WidgetsCategoriesElement {
  String get title {
    return describeEnum(this).capitalize();
  }
}