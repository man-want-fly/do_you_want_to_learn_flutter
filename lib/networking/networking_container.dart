
import 'package:flutter/material.dart';

import 'basic_networking_1.dart';
import 'basic_networking_2.dart';

class NetworkingContainer extends StatelessWidget {
  const NetworkingContainer({ Key? key, required this.title }) : super(key: key);

  final String title;
  final _items = _Networkings.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemBuilder: (context, i) => ListTile(
          title: Text(_items[i].toString()),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () => _onTapListItem(context, _items[i]),
        ),
        separatorBuilder: (_, x) => Divider(),
        itemCount: _items.length
      )
    );
  }

  void _onTapListItem(BuildContext context, _Networkings item) {
    switch (item) {
      case _Networkings.basic1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BasicNetworking1(title: item.toString()))
        );
        break;

      case _Networkings.basic2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BasicNetworking2(title: item.toString()))
        );
        break;

      default:
    }
  }
}

enum _Networkings {
  basic1, basic2
}