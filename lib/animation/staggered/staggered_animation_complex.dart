import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StaggeredAnimationComplexWidget extends StatefulWidget {
  const StaggeredAnimationComplexWidget({Key? key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _StaggeredAnimationComplexState(); 
}

class _StaggeredAnimationComplexState
    extends State<StaggeredAnimationComplexWidget> {
  
  final List<_Photo> _photos = List<_Photo>.generate(
    30, (index) => _Photo('lib/animation/staggered/images/pic${index + 1}.jpg', index)
  );

  final List<List<_PhotoFrame>> _photoFrames = [
    [const _PhotoFrame(1.0, 0.4)],
    [const _PhotoFrame(0.25, 0.3), const _PhotoFrame(0.75, 0.3)],
    [const _PhotoFrame(0.75, 0.3), const _PhotoFrame(0.25, 0.3)]
  ];

  static const double _photoBlockHeight = 576.0;

  int? _selectedPhotoIndex;

  @override
  Widget build(BuildContext context) {
    timeDilation = 20;

    final int photoBlockFrameCount = _photoFrames
      .map((e) => e.length)
      .reduce((value, element) => value + element);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SizedBox.expand(
        child: ListView.builder(
          padding: EdgeInsets.all(4),
          itemExtent: _photoBlockHeight,
          itemBuilder: (context, index) => _itemBuilder(context, index, photoBlockFrameCount)),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, int blockFrameCount) {
    final List<Widget> rows = [];
    int startIndex = index * blockFrameCount;
    final Color photoColor = Colors.green[600]!;
    for (var rowIndex = 0; rowIndex < _photoFrames.length; rowIndex++) {
      final List<Widget> rowChildren = [];
      final int rowLength = _photoFrames[rowIndex].length;
      for (var frameIndex = 0; frameIndex < rowLength; frameIndex ++) {
        final _PhotoFrame frame = _photoFrames[rowIndex][frameIndex];
        final int photoIndex = startIndex + frameIndex;
        rowChildren.add(
          Expanded(
            flex: (frame.width * 100.0).toInt(),
            child: Container(
              padding: EdgeInsets.all(4),
              height: frame.height * _photoBlockHeight,
              child: _PhotoItemWidget(
                photo: _photos[photoIndex],
                color: photoColor,
                selected: photoIndex == _selectedPhotoIndex,
                onTap: () => _selectPhoto(photoIndex),
              )
            )
          )
        );
      }
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: rowChildren)
      );
      startIndex += rowLength;
    }

    return Column(children: rows);
  }

  void _selectPhoto(int index) {
    setState(() {
      _selectedPhotoIndex = index == _selectedPhotoIndex ? null : index;
    });
  }
}

class _Photo {
  const _Photo(this.asset, this.id);
  final String asset;
  final int id;

  @override
  bool operator ==(dynamic other) {
    return true;
  }

  @override
  int get hashCode => id.hashCode;
}

class _PhotoFrame {
  const _PhotoFrame(this.width, this.height);
  final double width; 
  final double height;
}

class _PhotoItemWidget extends StatefulWidget {
  const _PhotoItemWidget({
    Key? key, 
    required this.photo, 
    this.color, this.onTap, 
    required this.selected
  }) : super(key: key);

  final _Photo photo;
  final Color? color;
  final VoidCallback? onTap;
  final bool selected;

  @override
  State<StatefulWidget> createState() => _PhotoItemState();
}

class _PhotoItemState extends State<_PhotoItemWidget> with TickerProviderStateMixin {

  late AnimationController _selectController;
  late Animation<double> _stackScaleAnimation;
  late Animation<RelativeRect> _imagePositionAnimation;
  late Animation<double> _checkScaleAnimation;
  late Animation<double> _checkSelectedOpacityAnimation;

  late AnimationController _repleaceController;
  late Animation<Offset> _repleaceNewPhotoAnimation;
  late Animation<Offset> _repleaceOldPhotoAnimation;
  late Animation<double> _removeCheckAnimation;

  late _Photo _oldPhoto;
  _Photo? _newPhoto;

  @override
  void initState() {
    super.initState();

    _oldPhoto = widget.photo;

    _selectController = AnimationController(
      duration: Duration(milliseconds: 300), 
      vsync: this
    );

    final Animation<double> easeSelection = CurvedAnimation(
      parent: _selectController, 
      curve: Curves.easeIn
    );

    _stackScaleAnimation = Tween(begin: 1.0, end: 0.85).animate(easeSelection);
    _checkScaleAnimation = Tween(begin: 0.0, end: 1.25).animate(easeSelection);
    _checkSelectedOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(easeSelection);
    _imagePositionAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0), 
      end: RelativeRect.fromLTRB(12.0, 12.0, 12.0, 12.0)
    ).animate(easeSelection);

    _repleaceController = AnimationController(
      duration: Duration(milliseconds: 300), 
      vsync: this
    );

    final Animation<double> easeInsert = CurvedAnimation(
      parent: _repleaceController, 
      curve: Curves.easeIn
    );

    _repleaceNewPhotoAnimation = Tween(
      begin: Offset(1.0, 0.0), 
      end: Offset.zero
    ).animate(easeInsert);
    _repleaceOldPhotoAnimation = Tween(
      begin: Offset.zero, 
      end: Offset(-1.0, 0.0)
    ).animate(easeInsert);
    _removeCheckAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _repleaceController, 
        curve: Interval(0.0, 0.25, curve: Curves.easeIn)
      )
    );
  }

  @override
  void dispose() {
    _selectController.dispose();
    _repleaceController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _PhotoItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.photo != oldWidget.photo) {
      _replace(oldWidget.photo, widget.photo);
    }
    if(widget.selected != oldWidget.selected) {
      _select();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: SlideTransition(
              position: _repleaceOldPhotoAnimation,
              child: Material(
                color: widget.color,
                child: InkWell(
                  onTap: widget.onTap,
                  child: ScaleTransition(
                    scale: _stackScaleAnimation,
                    child: Stack(
                      children: [
                        PositionedTransition(
                          rect: _imagePositionAnimation, 
                          child: Image.asset(_oldPhoto.asset, fit: BoxFit.cover)
                        ),
                        Positioned(
                          top: 0.0, left: 0.0,
                          child: FadeTransition(
                            opacity: _checkSelectedOpacityAnimation,
                            child: FadeTransition(
                              opacity: _removeCheckAnimation, 
                              child: ScaleTransition(
                                alignment: Alignment.topLeft,
                                scale: _checkScaleAnimation, 
                                child: _PhotoCheck(),
                              )
                            )
                          )
                        ),
                        PositionedTransition(
                          rect: _imagePositionAnimation, 
                          child: Container(
                            margin: EdgeInsets.all(8),
                            alignment: Alignment.topRight,
                            child: Text(
                              widget.photo.id.toString(),
                              style: TextStyle(color: Colors.green)
                            )
                          )
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
        Positioned.fill(
          child: ClipRect(
            child: SlideTransition(
              position: _repleaceNewPhotoAnimation, 
              child: _newPhoto == null ? null : Image.asset(_newPhoto!.asset, fit: BoxFit.cover)
            )
          )
        )
      ],
    );
  }

  Future<void> _replace(_Photo oldPhoto, _Photo newPhoto) async {
    try {
      setState(() {
        _oldPhoto = oldPhoto;
        _newPhoto = newPhoto;
      });
      await _repleaceController.forward().orCancel;
      setState(() {
        _oldPhoto = newPhoto;
        _newPhoto = null;
        _repleaceController.value = 0.0;
        _selectController.value = 0.0;
      });
    } on TickerCanceled {

    }
  }

  void _select() {
    if(widget.selected) {
      _selectController.forward();
    } else {
      _selectController.reverse();
    }
  }
}

class _PhotoCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Icon(Icons.check, size: 32, color: Colors.blue)
    );
    
  }
}