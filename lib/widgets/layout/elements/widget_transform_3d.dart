import 'package:flutter/material.dart';

class WidgetTransform3D extends StatefulWidget {
  const WidgetTransform3D({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _WidgetTransform3DState();
}

class _WidgetTransform3DState extends State<WidgetTransform3D> {

  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(0.01 * _offset.dy)
        ..rotateY(0.01 * _offset.dx),
      alignment: AlignmentDirectional.center,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _offset += details.delta;
          });
        },
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          backgroundColor: Colors.blue,
          body: Image.asset('images/watermelon.png')
        )
      )
    );
  }
}