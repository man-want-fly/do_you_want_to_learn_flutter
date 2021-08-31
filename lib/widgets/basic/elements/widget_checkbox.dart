import 'dart:math';

import 'package:flutter/material.dart';

class WidgetCheckbox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WidgetCheckboxState(); 
}

class _WidgetCheckboxState extends State<WidgetCheckbox> {

  Map<String, bool> _lightStates = Map<String, bool>.fromIterable(
    List.generate(20, (index) => 'Room-$index'), 
    key: (item) => item, 
    value: (_) => Random().nextBool()
  );


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: _lightStates.keys.map((name) => CheckboxListTile(
                activeColor: Colors.blue,
                checkColor: Colors.yellow,
                value: _lightStates[name],
                onChanged: (newValue) {
                  setState(() {
                    _lightStates[name] = newValue!;
                  });
                }, 
                title: Text(name)
              )).toList()
            )
          )
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _lightStates.keys.map((name) => _BulbCard(
              isOn: _lightStates[name]!, 
              room: name,
              lightStateChanged: (newValue) {
                setState(() {
                  _lightStates[name] = newValue;
                });
              },
            )).toList()
          )
        )
      ],
    );
  }
}

class _BulbCard extends StatelessWidget {
  const _BulbCard({required this.isOn, required this.room, required this.lightStateChanged});

  final bool isOn;
  final String room;
  final ValueChanged<bool> lightStateChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2)
          )
        ],
        color: Colors.lightGreen
      ),
      margin: EdgeInsets.all(8),
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              lightStateChanged(!isOn);
            }, 
            iconSize: 100,
            icon: Icon(
              Icons.lightbulb, 
              color: isOn ? Colors.yellow : Colors.grey
            )
          ),
          Text(
            room, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 24, 
              color: Colors.blue
            )
          )
        ]
      )
    );    
  }
}