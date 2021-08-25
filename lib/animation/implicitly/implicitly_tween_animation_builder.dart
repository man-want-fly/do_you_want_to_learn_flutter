import 'package:flutter/material.dart';

class ImplcitilyTweenAnimationBuilder extends StatelessWidget {
  ImplcitilyTweenAnimationBuilder({Key? key, required this.title}) : super(key: key);
  final String title;

  final Tween<double> _tween = Tween(begin: 0.0, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 5),
        curve: Curves.linear,
        builder: (_, double change, child) {
          return Transform.scale(alignment: Alignment.topLeft, scale: 1.5 * change, child: child);
        },
        onEnd: () {
          debugPrint('on end');
        },
        child: Container(width: 100.0, height: 100.0, color: Colors.red),
      )
    );
  }
}
