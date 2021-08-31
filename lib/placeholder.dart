import 'dart:math';
import 'package:flutter/material.dart';

class PlaceholderWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PlaceholderState();
}

class _PlaceholderState extends State<PlaceholderWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Color _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      value: 0,
      lowerBound: 0,
      upperBound: 1,
      animationBehavior: AnimationBehavior.preserve
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    
    _animation.addStatusListener((status) {
      debugPrint(status.toString());
      setState(() {
        _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      });
    });

    _controller.forward();
    // _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Depend on you 👊')),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Text('You can fill this part'),
              AnimatedBuilder(
                animation: _animation, 
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * 2 * pi, 
                    child: child
                  );
                },
                child: Icon(
                  Icons.thumb_up_alt, 
                  size: 64, 
                  color: _color 
                )
              )
            ]
          )
        )
      )
    );
  }
}
