import 'dart:math';
import 'package:flutter/material.dart';

class WidgetMorePage extends StatefulWidget {
  WidgetMorePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _WidgetMoreState();
}

class _WidgetMoreState extends State<WidgetMorePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      value: 0,
      lowerBound: 0,
      upperBound: 1,
      animationBehavior: AnimationBehavior.preserve
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);

    // _controller.forward();
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Text('You can fill this part'),
              AnimatedIcon(
                icon: AnimatedIcons.add_event, progress: _animation, 
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                size: 64,
              )
            ]
          )
        )
      )
    );
  }
}
