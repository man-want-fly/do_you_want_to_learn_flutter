import 'package:do_you_want_to_learn_flutter/animation/hero/hero_animation_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroAnimationHome extends StatelessWidget {
  const HeroAnimationHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation')),
      body: HeroAnimationSomeHero(
        child: Column(
          children: [
            Image.asset('images/watermelon.png', width: 100),
            Text('Watermelon')
          ]
        ),
        onTap: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => HeroAnimationDetail())
        ),
      )
    );
  }
}

class HeroAnimationSomeHero extends StatelessWidget {
  const HeroAnimationSomeHero({Key? key, this.onTap, required this.child}) : super(key: key);

  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(tag: this.toString(), child: GestureDetector(child: child, onTap: onTap));
  }
}
