import 'package:flutter/material.dart';
import './widget_row.dart';

class WidgetInfinityList extends StatefulWidget {
  const WidgetInfinityList({Key? key}) : super(key: key);

  @override
  _WidgetInfinityListState createState() => _WidgetInfinityListState();
}

class _WidgetInfinityListState extends State<WidgetInfinityList> {
  //TODO create more row when scroll to bottom
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) return Divider();
        return WidgetRow();
      },
    ));
  }
}
