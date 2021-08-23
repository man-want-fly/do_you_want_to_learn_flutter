import 'package:flutter/material.dart';
import './widget_row.dart';

class WidgetInfinityList extends StatefulWidget {
  const WidgetInfinityList({Key? key}) : super(key: key);

  @override
  _WidgetInfinityListState createState() => _WidgetInfinityListState();
}

class _WidgetInfinityListState extends State<WidgetInfinityList> {
  final _widgetRows = <WidgetRow>[];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        final index = i ~/ 2;
        if (i.isOdd) return Divider();
        if (index >= _widgetRows.length) {
          _widgetRows.add(WidgetRow());
        }
        return _widgetRows[index];
      },
    ));
  }
}
