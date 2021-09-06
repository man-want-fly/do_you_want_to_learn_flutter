import 'package:do_you_want_to_learn_flutter/animation/implicitly/implicitly_animated_align.dart';
import 'package:do_you_want_to_learn_flutter/animation/implicitly/implicitly_animated_container.dart';
import 'package:do_you_want_to_learn_flutter/animation/implicitly/implicitly_animated_cross_fade.dart';
import 'package:do_you_want_to_learn_flutter/placeholder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/extensions/string_extension.dart';
import 'implicitly_animated_default_text_style.dart';
import 'implicitly_tween_animation_builder.dart';

enum ImplicitAnimation {
  tweenAnimationBuilder,
  align,
  container,
  defaultTextStyle,
  opacity,
  animatedCrossFade
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
            onTap: () => _listItemOnTap(context, item) 
          );
        }, 
        separatorBuilder: (_, idx) => Divider(), 
        itemCount: _items.length
      ),
    );
  }

  void _listItemOnTap(BuildContext context, ImplicitAnimation item) {
    Widget aWidget = PlaceholderWidget();
    switch (item) {
      case ImplicitAnimation.tweenAnimationBuilder:
        aWidget = ImplcitilyTweenAnimationBuilder(title: item.title);
        break;
      case ImplicitAnimation.align:
        aWidget = ImplicitlyAnimatedAlign(title: item.title);
        break;
      case ImplicitAnimation.container:
        aWidget = ImplicitlyAnimatedContainer(title: item.title);
        break;
      case ImplicitAnimation.defaultTextStyle:
        aWidget = ImplicitlyAnimatedDefaultTextStyle(title: item.title);
        break;
      case ImplicitAnimation.animatedCrossFade:
        aWidget = ImplicitlyAnimatedCrossFade(title: item.title);
        break;
      default:
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => aWidget)
    );
  }
}
