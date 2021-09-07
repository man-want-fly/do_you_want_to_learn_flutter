import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';

// void main() => runApp(MyApp());

void main() {
  runZonedGuarded(
    () {
      runApp(MyApp());
    },
    (Object error, StackTrace stack) {
      // Zone中未捕获异常处理回调
      print("Intercepted error: $error -> $stack");
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        // 拦截应用中所有调用print输出日志的行为
        parent.print(zone, "Intercepted print: $line");
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomeWidget(title: 'Do you want to learn Flutter?'),
    );
  }
}
