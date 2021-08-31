
import 'package:flutter/material.dart';

class WidgetPaint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetPaintState();
  }
}

class _WidgetPaintState extends State<WidgetPaint> {
  List<Offset> _points = <Offset>[];

  void _addDragPoints(Offset globalPosition) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    Offset? point = renderBox?.globalToLocal(globalPosition);
    if (point != null) {
      setState(() {
        _points = List.from(_points)..add(point!);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          setState(() {
            _points = [];
          });
          _addDragPoints(details.globalPosition);
        },
        onPanUpdate: (DragUpdateDetails details) {
          _addDragPoints(details.globalPosition);
        },
        onPanEnd: (DragEndDetails details) {

        },
        child: CustomPaint(
            painter: _WidgetPainter(_points),
            size: Size.infinite),
      ),
    );
  }
}

class _WidgetPainter extends CustomPainter {
  final List<Offset> points;

  _WidgetPainter(this.points);

  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 1; i < points.length; i++) {
      if (points[i - 1] != null && points[i] != null) {
        canvas.drawLine(points[i - 1], points[i], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _WidgetPainter) {
      _WidgetPainter oldPainter = oldDelegate;
      return oldPainter.points != points;
    }
    return true;
  }
}
