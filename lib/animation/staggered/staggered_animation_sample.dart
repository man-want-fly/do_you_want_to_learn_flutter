import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StaggeredAnimationSimpleWidget extends StatefulWidget {
  const StaggeredAnimationSimpleWidget({Key? key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _StaggeredAnimationSimpleState();
}

class _StaggeredAnimationSimpleState extends State<StaggeredAnimationSimpleWidget> with TickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000), 
      vsync: this
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAnimation,
        child: Center(
          child: Container(
            width: 300, 
            height: 300,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.blue)
            ),
            child: _StaggeredAnimation(parent: _animationController.view),
          )
        )
      )
    );
  }

  Future<void> _playAnimation() async {
    try {
      await _animationController.forward().orCancel;
      await _animationController.reverse().orCancel;
    } on TickerCanceled {
      print('TickerCanceled ---------');
    }
  }
}

class _StaggeredAnimation extends StatelessWidget {
  _StaggeredAnimation({Key? key, required this.parent}) : 
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: parent, curve: Interval(0.0, 0.1, curve: Curves.ease))
    ),
    width = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(parent: parent, curve: Interval(0.125, 0.25, curve: Curves.ease))
    ),
    height = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(parent: parent, curve: Interval(0.25, 0.373, curve: Curves.ease))
    ),
    padding = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 16), 
      end: EdgeInsets.only(bottom: 75)
    ).animate(
      CurvedAnimation(parent: parent, curve: Interval(0.25, 0.375, curve: Curves.ease))
    ),
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(4), 
      end: BorderRadius.circular(16)
    ).animate(
      CurvedAnimation(parent: parent, curve: Interval(0.375, 0.5, curve: Curves.ease))
    ),
    color = ColorTween(begin: Colors.green, end: Colors.purple).animate(
      CurvedAnimation(parent: parent, curve: Interval(0.5, 0.75, curve: Curves.ease))
    ),
    super(key: key);

  final Animation<double> parent;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius> borderRadius;
  final Animation<Color?> color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: parent, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            borderRadius: borderRadius.value,
            border: Border.all(color: Colors.cyan, width: 3)
           ),
        ),
      ),
    );
  }
}