import 'dart:math';

import 'package:do_you_want_to_learn_flutter/animation/hero/hero_animation_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeroAnimationComplex extends StatefulWidget {
  const HeroAnimationComplex({ Key? key }) : super(key: key);

  @override
  _HeroAnimationComplexState createState() => _HeroAnimationComplexState();
}

class _HeroAnimationComplexState extends State<HeroAnimationComplex> {

  final _minR = 32.0, _maxR = 160.0;
  final _opacityCurve = Interval(0.0, 1.0, curve: Curves.fastOutSlowIn);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero')),
      body: Container(
        padding: EdgeInsets.all(32.0),
        alignment: Alignment.bottomCenter,
        child: Row(
          children: List<int>.generate(3, (i) => i)
            .map((e) => Padding(
              padding: EdgeInsets.only(right: 8.0), 
              child: _buildHero(context, '$e'))
            )
            .toList()
        )
      )
    );
  }

  Widget _buildHero(BuildContext context, Object tag) => Container(
    width: _minR * 3,
    height: _minR * 3,
    child: HeroAnimationSomeHero(
      tag: tag,
      createRectTween: (b, e) => MaterialRectCenterArcTween(begin: b, end: e),
      onTap: () => Navigator.push(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, animation, x) => AnimatedBuilder(
            animation: animation, 
            builder: (_, child) => Opacity(
              opacity: _opacityCurve.transform(animation.value),
              child: _buildPage(context, tag)
            )
          )
        )
      ),
      child: _Growing(
        maxRadius: _maxR,
        child: Container(color: Colors.blue)
      )
    )
  );

  Widget _buildPage(BuildContext context, Object tag) => Container(
    color: Colors.green,
    child: Center(
      child: Card(
        child: SizedBox(
          width: _maxR * 2.0,
          height: _maxR * 2.0,
          child: HeroAnimationSomeHero(
            tag: tag,
            createRectTween: (b, e) => MaterialRectCenterArcTween(begin: b, end: e),
            onTap: () => Navigator.of(context).pop(),
            child: _Growing(
              maxRadius: _maxR, 
              child: Container(color: Colors.blue)
            )
          )
        )
      )
    )
  );
}

class _Growing extends StatelessWidget {
  const _Growing({ 
    Key? key, 
    required this.maxRadius, 
    required this.child 
  }) : clipSize = (maxRadius / sqrt2) * 2.0,
  super(key: key);

  final double maxRadius;
  final Widget child;
  final double clipSize;

  @override
  Widget build(BuildContext context) => ClipOval(
    child: Center(
      child: SizedBox(
        width: clipSize, 
        height: clipSize,
        child: ClipRect(child: child)
      )
    )
  );
  
}