import 'package:do_you_want_to_learn_flutter/animation/hero/hero_animation_home.dart';
import 'package:flutter/material.dart';

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
