import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitlyAnimatedDefaultTextStyle extends StatefulWidget {
  final String title;

  ImplicitlyAnimatedDefaultTextStyle({Key? key, required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImplicitlyAnimatedDefaultTextStyleState();
  }
}

class _ImplicitlyAnimatedDefaultTextStyleState
    extends State<ImplicitlyAnimatedDefaultTextStyle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<TextStyle> _animation;

  late TextStyle _style;

  @override
  void initState() {
    super.initState();

    _style = TextStyle(
      color: Colors.blue,
      fontSize: 14,
    );

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = TextStyleTween(
            begin: TextStyle(color: Colors.blue, fontSize: 14),
            end: TextStyle(color: Colors.red, fontSize: 24))
        .animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: _style,
              overflow: TextOverflow.ellipsis,
              child: Text("DefaultTextStyle"),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultTextStyleTransition(
              style: _animation,
              child: Text("DefaultTextStyleTransition"),
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedDefaultTextStyle(
              duration: Duration(seconds: 1),
              style: _style,
              child: Text("AnimatedDefaultTextStyle"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _style = TextStyle(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    fontSize: (Random().nextDouble() * 20 + 10),
                  );
                });
              },
              child: Text("change style"),
            ),
          ],
        ),
      ),
    );
  }
}
