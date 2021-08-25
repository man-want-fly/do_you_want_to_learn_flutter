import 'package:flutter/material.dart';

class HeroAnimationDetail extends StatelessWidget {
  const HeroAnimationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: GestureDetector(
        child: Hero(
          tag: 'hero-tag', 
          child: Column(
            children: [
              Image.asset('images/watermelon.png', width: 400),
              Text('Watermelon')
            ]
          )
        ),
        onTap: () => Navigator.of(context).pop()
      )
    );
  }
}
