import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16), 
      child: Image(
        image: AssetImage('images/watermelon.png'), 
        loadingBuilder: (content, wgt, event) {
          if (event == null) { return wgt; }
          return Center(child: Text('Loading...'));
        },
        colorBlendMode: BlendMode.difference,
        repeat: ImageRepeat.repeatY,
        filterQuality: FilterQuality.low,
        fit: BoxFit.scaleDown,
      )
    );
  }
}