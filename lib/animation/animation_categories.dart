import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';
import 'hero/hero_animation_home.dart';
import 'implicitly/implicitly_animations.dart';

enum AnimationCategory { implicity, hero }

class AnimationCategoriesPage extends StatelessWidget {
  AnimationCategoriesPage({ Key? key, required this.title }) : super(key: key);

  final String title;

  final List<AnimationCategory> _categories = AnimationCategory.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemBuilder: (_, idx) {
          final item = _categories[idx];
          String title = describeEnum(item).capitalize();
          return ListTile(
            title: Text(title),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _listItemOnTap(context, item)
          );
        }, 
        separatorBuilder: (_, idx) => Divider(),
        itemCount: _categories.length
      )
    );
  }

  void _listItemOnTap(BuildContext context, AnimationCategory item) {
    switch (item) {
      case AnimationCategory.implicity:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => ImplicitlyAnimationsWidget(title: title))
        );
        break;
      case AnimationCategory.hero:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => HeroAnimationHome())
        );
        break;
    }
  }
}
