import 'package:flutter/material.dart';

class ImplicitlyAnimatedContainer extends StatefulWidget {
  ImplicitlyAnimatedContainer({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _ImplicitlyAnimatedContainerState();
}

class _ImplicitlyAnimatedContainerState
    extends State<ImplicitlyAnimatedContainer> {
  
  bool _bigger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            child: AnimatedContainer(
              curve: Curves.easeInCubic,
              duration: Duration(seconds: 3),
              width: _bigger ? 400 : 100,
              // color: Colors.blue,
              child: Image.asset('images/watermelon.png'),
              onEnd: () {
                // setState(() {
                //   _width -= 100;
                // });
              },
            ),
            onTap: () {
              setState(() {
                _bigger = !_bigger;
              });
            },
          )
        ]));
  }
}
