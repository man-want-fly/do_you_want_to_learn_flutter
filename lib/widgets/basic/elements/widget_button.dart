import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16), 
      child: Column(children: [
        ElevatedButton(onPressed: () {}, child: Text('ElevatedButton')),
        TextButton(onPressed: () {}, child: Text('TextButton')),
        OutlinedButton(onPressed: () {}, child: Text('OutlinedButton')),
        IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
        Divider(),
        ElevatedButton.icon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text('ElevatedButtonWithIcon')),
        TextButton.icon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text('TextButtonWithIcon')),
        OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text('OutlinedButtonWithIcon'))
      ])
    );
  }
}