import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';

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
          return ListTile(
            title: Text(describeEnum(_categories[idx]).capitalize()),
            trailing: Icon(Icons.arrow_forward_ios)
          );
        }, 
        separatorBuilder: (_, idx) => Divider(),
        itemCount: _categories.length
      )
    );
  }
}
