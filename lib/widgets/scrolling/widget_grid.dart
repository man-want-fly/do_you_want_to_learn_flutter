import 'dart:math';

import 'package:flutter/material.dart';

class WidgetGridView extends StatefulWidget {
  const WidgetGridView({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  _WidgetGridViewState createState() => _WidgetGridViewState();
}

class _WidgetGridViewState extends State<WidgetGridView> {

  List<int> _data = [0];
  double _currentSliderValue = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _currentSliderValue.round()
            ),
            itemBuilder: (_, i) {
              if (i == _data.length - 1 && _data.length < 50) {
                _fetchData();
              }
              return InkResponse(
                child: GridTile(
                  child: Container(
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    child: Center(
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  )
                ),
                onTap: () {
                  print('tapped on item: $i');
                },
              );
            },
            itemCount: _data.length
          ),
          SafeArea(
            minimum: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 44.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 15.0)
                  ]
                ),
                child: Slider(
                  min: 1, max: 8,
                  value: _currentSliderValue,
                  divisions: 7,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (value) => setState(() => _currentSliderValue = value)
                )
              )
            )
          )
        ]
      )
    );
  }

  void _fetchData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _data.addAll(List.generate(10, (index) => index));
      });
    });
  }
}