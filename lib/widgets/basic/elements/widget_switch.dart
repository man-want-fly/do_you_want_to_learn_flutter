import 'package:flutter/material.dart';

class WidgetSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WidgetSwitchState();
}

class _WidgetSwitchState extends State<WidgetSwitch> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'The switch state now is: '),
                TextSpan(
                  text: _value.toString(), 
                  style: TextStyle(
                    color: _value ? Colors.blue : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                  )
                )
              ]
            )
          ),
          Switch(
            value: _value, 
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            activeColor: Colors.blue,
            activeTrackColor: Colors.green,
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.black,
          )
        ]
      )
    );
  }
}
