import 'package:flutter/material.dart';

class HeroAnimationSimple extends StatelessWidget {
  const HeroAnimationSimple({Key? key}) : super(key: key);
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
  const HeroAnimationSomeHero({
    Key? key,
    this.tag, 
    required this.child, 
    this.createRectTween,
    this.onTap
  }) : super(key: key);

  final Object? tag;
  final VoidCallback? onTap;
  final Widget child;
  final Tween<Rect?> Function(Rect?, Rect?)? createRectTween;

  @override
  Widget build(BuildContext context) => Hero(
    tag: tag ?? this.toString(), 
    createRectTween: createRectTween, 
    child: GestureDetector(child: child, onTap: onTap)
  );
}
class HeroAnimationDetail extends StatelessWidget {
  const HeroAnimationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: HeroAnimationSomeHero(
        child: Column(
          children: [
            Image.asset('images/watermelon.png', width: 400),
            Text('Watermelon'),
            Text('''
            通过使用 Flutter 的 动画库，您可以为 UI 中的组件添加运动和创建视觉效果。
            便地使用— 隐式动画组件会管理动画效果，用户不需要再进行额外的处理。
            ''')
          ]
        ),
        onTap: () => Navigator.of(context).pop()
      )
    );
  }
}