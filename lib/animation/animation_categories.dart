import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';
import 'implicitly/implicitly_animations.dart';

enum AnimationCategory { implicity }

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
          String title = describeEnum(_categories[idx]).capitalize();
          return ListTile(
            title: Text(title),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => ImplicitlyAnimationsWidget(title: title))
            )
          );
        }, 
        separatorBuilder: (_, idx) => Divider(),
        itemCount: _categories.length
      )
    );
  }
}
