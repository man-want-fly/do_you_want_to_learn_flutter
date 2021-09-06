import 'package:flutter/material.dart';

class ImplicitlyAnimatedCrossFade extends StatefulWidget {
  final String title;

  ImplicitlyAnimatedCrossFade({Key? key, required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImplicitlyAnimatedCrossFadeState();
  }
}

class _ImplicitlyAnimatedCrossFadeState
    extends State<ImplicitlyAnimatedCrossFade> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedCrossFade(
              duration: Duration(seconds: 1),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Text(
                  'first child',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              secondChild: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'second child',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      bottom: 0,
                      key: bottomChildKey,
                      child: bottomChild,
                    ),
                    Positioned(
                      key: topChildKey,
                      child: topChild,
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showFirst = !_showFirst;
          });
        },
        child: Icon(
            _showFirst ? Icons.swipe_rounded : Icons.swipe_outlined
        ),
      ),
    );
  }
}
