import 'dart:math';

import 'package:flutter/material.dart';

class WidgetIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16), child: _randomIcon());
  }

  Icon _randomIcon() {
    List<IconData> icons = [
      Icons.ac_unit,
      Icons.baby_changing_station,
      Icons.cabin,
      Icons.dangerous,
      Icons.e_mobiledata
    ];
    icons.shuffle();
    return Icon(
      icons.first,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      size: Random().nextDouble() * 500
    );
  }
}