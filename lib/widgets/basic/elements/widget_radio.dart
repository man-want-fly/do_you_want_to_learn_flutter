import 'package:flutter/material.dart';

class WidgetRadio extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _WidgetRadioState();
}

class _WidgetRadioState extends State<WidgetRadio> with TickerProviderStateMixin {

  final List<_Choice> _choices = _Choice.values.where((element) => element != _Choice._).toList();
  var _result;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('1 + 1 = ?'),
        Column(
          children: _choices.map((value) => RadioListTile<_Choice>(
            title: Text(value.index.toString()),
            value: value, 
            groupValue: _result, 
            onChanged: (changed) {
              _hudForChoiceChanged(changed!);
              setState(() {
                _result = changed;
              });
            }
          )).toList(),
        )
      ],
    );
  }

  void _hudForChoiceChanged(_Choice choice) {
    IconData iconData = choice == _Choice.two ? Icons.thumb_down : Icons.thumb_up;
    Color color = choice == _Choice.two ? Colors.red : Colors.blue;
    String text = choice == _Choice.two ? 'Stupid' : 'So clever 🤪';
    showDialog(
      context: context, 
      builder: (_) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: color),
              Text(text)
            ])
        );
      }
    );
  }
}

enum _Choice {
  _, one, two, three, four
}