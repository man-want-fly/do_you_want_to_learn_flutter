import 'package:flutter/material.dart';

class ImplicitlyAnimatedAlign extends StatefulWidget {
  ImplicitlyAnimatedAlign({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<StatefulWidget> createState() => _ImplicitlyAnimatedAlignState();
}

class _ImplicitlyAnimatedAlignState extends State<ImplicitlyAnimatedAlign> {

  Alignment _alignment = Alignment.topRight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _alignment = Alignment.bottomLeft;
          });
        },
        child: AnimatedAlign(
          alignment: _alignment,
          child: Container(
            width: 100, height: 100, 
            color: Colors.red
          ),
          curve: Curves.easeInOut,
          duration: Duration(seconds: 5),
          onEnd: () {
            setState(() {
              _alignment = Alignment.topLeft;
            });
          },
        )
      )
    );
  }
}
