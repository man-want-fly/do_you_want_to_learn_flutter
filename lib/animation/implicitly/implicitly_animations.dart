import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';
import 'implicitly_tween_animation_builder.dart';

enum ImplicitAnimation {
  tweenAnimationBuilder,
  align,
  container,
  defaultTextStyle,
  opacity
}

extension _ImplicitAnimationExtension on ImplicitAnimation {
  String get title {
    return describeEnum(this).capitalize();
  }
}

class ImplicitlyAnimationsWidget extends StatelessWidget {
  ImplicitlyAnimationsWidget({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<ImplicitAnimation> _items = ImplicitAnimation.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemBuilder: (context, idx) {
          ImplicitAnimation item = _items[idx];
          return ListTile(
            leading: Icon(Icons.twenty_one_mp),
            title: Text(item.title),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) { 
                  return ImplcitilyTweenAnimationBuilder(title: item.title);
                })
              );
            }
          );
        }, 
        separatorBuilder: (_, idx) => Divider(), 
        itemCount: _items.length
      ),
    );
  }
}
