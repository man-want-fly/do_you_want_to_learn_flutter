import 'dart:math';
import 'package:do_you_want_to_learn_flutter/more.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';
import 'extensions/string_extension.dart';

enum Categories {
  widgets, animation, file, network, more // and so on
}

extension _CategoriesEx on Categories {
  Icon get icon {
    IconData data;
    switch (this) {
      case Categories.widgets:
        data = Icons.widgets; 
        break;
      case Categories.animation:
        data = Icons.animation; 
        break;
      case Categories.file:
        data = Icons.file_present;
        break;
      case Categories.network:
        data = Icons.network_check;
        break;
      case Categories.more:
        data = Icons.more_horiz;
        break;
    }
    return Icon(
      data, 
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
    );
  }

  String get title {
    return describeEnum(this).capitalize();
  }
}

class CategoriesPage extends StatelessWidget {

  final _items = Categories.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: ListView.separated(
        itemBuilder: (context, idx) {
          Categories item = _items[idx];
          return ListTile(
            leading: item.icon,
            title: Text(item.title),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => _listItemTapped(item, context)
          );
        }, 
        separatorBuilder: (context, idx) => Divider(), 
        itemCount: _items.length
      ),
    );
  }

  void _listItemTapped(Categories item, BuildContext context) {
    // TODO: route manager
    switch (item) {
      case Categories.widgets:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => WidgetsPage())
        );
        break;
      default: 
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => MorePage(title: item.title))
        );
        break;
    }
  }
}