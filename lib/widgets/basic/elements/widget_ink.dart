import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetInk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetInkState();
  }
}

class _WidgetInkState extends State<WidgetInk> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("InkWell widget: "),
              InkWell(
                onTap: () {
                  debugPrint("on tap InkWell");
                },
                // borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Click Here InkWell"),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text("Ink widget:"),
              Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red, Colors.yellow],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    debugPrint("on tap Ink");
                  },
                  onFocusChange: (value) {
                    debugPrint("on Ink focus change: $value");
                  },
                  onHighlightChanged: (value) {
                    debugPrint("on Ink highlight change: $value");
                  },
                  splashColor: Colors.redAccent,
                  // highlightColor: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text("Click Here Ink"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
