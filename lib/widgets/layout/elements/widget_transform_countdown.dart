import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class WidgetTransfromCountdown extends StatelessWidget {
  const WidgetTransfromCountdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Countdown')),
      backgroundColor: Colors.blue,
      body: Center(
        child: _FlipCard(
          itemBuilder: (_, index) => Container(
            alignment: Alignment.center,
            width: 160,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 56,
                color: Colors.white
              )
            )
          ),
          itemsCount: double.maxFinite.toInt()
        )
      )
    );
  }
}

class _FlipCard extends StatefulWidget {
  const _FlipCard({
    Key? key,
    required this.itemBuilder,
    required this.itemsCount,
  }) : super(key: key);

  final Widget Function(BuildContext, int) itemBuilder;
  final int itemsCount;

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Timer _timer; // TODO: change to stream

  final _period = Duration(milliseconds: 1200);
  int _currentIndex = 0;
  bool _isReversed = false; 
  final _perspective = 0.003;

  Widget? _previous, _next;
  Widget? _topOver, _topUnder, _bottomOver, _bottomUnder;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: _period * 0.5, vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isReversed = true;
          _controller.reverse();
        }
      })
      ..addListener(() => setState(() => {}));
      
    _animation = Tween(begin: double.minPositive, end: pi / 2).animate(_controller);

    _timer = Timer.periodic(_period, (_) {        
      _currentIndex += 1;
      _previous = null;
      _isReversed = false;
      _controller.forward();
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildCards(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTopFlipCard(),
        Padding(padding: EdgeInsets.only(top: 2)),
        _buildBottomFlipCard()
      ]
    );
  }

  void _buildCards(BuildContext context) {
    Widget buildClip(Alignment alignment, Widget? child) => ClipRect(
      child: Align(alignment: alignment, heightFactor: 0.5, child: child)
    );

    if (_previous == null) {
      _previous = _next ?? widget.itemBuilder(context, _currentIndex);
      _next = null;
      _topOver = _topUnder ?? buildClip(Alignment.topCenter, _previous);
      _bottomUnder = _bottomOver ?? buildClip(Alignment.bottomCenter, _previous);
    }
    if (_next == null) {
      _next = widget.itemBuilder(context, _currentIndex + 1);
      _topUnder = buildClip(Alignment.topCenter, _next);
      _bottomOver = buildClip(Alignment.bottomCenter, _next);
    }
  }

  Widget _buildTopFlipCard() => Stack(
    children: [
      Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(double.minPositive),
        child: _topUnder
      ),
      Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(_isReversed ? pi / 2 : _animation.value),
        child: _topOver,
      )
    ]
  );

  Widget _buildBottomFlipCard() => Stack(
    children: [
      Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(double.minPositive),
        child: _bottomUnder
      ),
      Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(_isReversed ? -_animation.value : pi / 2),
        child: _bottomOver
      )
    ]
  );
}
