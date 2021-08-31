import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetTextField extends StatefulWidget {

  @override
  _WidgetTextFieldState createState() => _WidgetTextFieldState();
}

class _WidgetTextFieldState extends State<WidgetTextField> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16), 
      child: TextField(
        decoration: InputDecoration(
          alignLabelWithHint: false, 
          labelText: 'label text',
          labelStyle: TextStyle(backgroundColor: Colors.green, color: Colors.white),
          helperText: 'helper text',
          helperStyle: TextStyle(backgroundColor: Colors.blue, color: Colors.yellow),
          hintText: 'This is hint',
          hintStyle: TextStyle(color: Colors.deepOrange),
          // hintTextDirection: TextDirection.rtl
          // hintMaxLines: 5,
          // errorText: 'This is error'
          // floatingLabelBehavior: FloatingLabelBehavior.never
          prefix: Text('Prefix: '),
          prefixIcon: Icon(Icons.ac_unit),
          suffix: Text('suffix'),
          suffixIcon: Icon(Icons.engineering),
          counter: Text(_count > 0 ? '$_count' : 'nothing input'),
          filled: true,
          fillColor: Colors.cyan,
          // focusColor: Colors.green
          // hoverColor: Colors.orange
          // enabledBorder: OutlineInputBorder()
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          // semanticCounterText: 'semanticCounterText'
        ),
        // textAlign: TextAlign.right, 
        style: TextStyle(backgroundColor: Colors.brown, color: Colors.white, fontSize: 18),
        cursorColor: Colors.black,
        cursorWidth: 10,
        cursorHeight: 44,
        onChanged: (value) {
          print('changed: --- $value');
          setState(() {
            _count = value.length;
          });
        },
        onTap: () {
          print('on tap');
        },
        onSubmitted: (text) {
          print('submitted: $text');
        },
        // maxLines: 100,
        // cursorHeight: 100
      )
    );
  } 
}