import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(16), child: _MainChildWidget());
  }
}

// MARK: - _MainChild
class _MainChildWidget extends StatefulWidget {
  @override
  _MainChildState createState() => _MainChildState();
}

class _MainChildState extends State<_MainChildWidget> {
  TextAlign _align = TextAlign.left;
  Color _color = Colors.black;

  void _textAlignHasChanged(TextAlign align) {
    setState(() {
      _align = align;
    });
  }

  void _textColorHasChanged(Color color) {
    setState(() {
      _color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: double.infinity),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Text(
              'this is text',
              textAlign: _align, 
              style: TextStyle(color: _color)
            )
          )
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: _ToolsWidget(
            textAlignValueChanged: _textAlignHasChanged,
            textColorValueChanged: _textColorHasChanged,
          )
        )
      ]
    );
  }
}

// MARK: - _ToolsWidget
class _ToolsWidget extends StatefulWidget {
  _ToolsWidget({
    Key? key,
    required this.textAlignValueChanged,
    required this.textColorValueChanged
  }) : super(key: key);

  final ValueChanged<TextAlign> textAlignValueChanged;
  final ValueChanged<Color> textColorValueChanged;

  @override
  _ToolsState createState() => _ToolsState();
}

class _ToolsState extends State<_ToolsWidget> {

  TextAlign _currentTextAlign = TextAlign.left;
  TextColors _textColor = TextColors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundCornerDropdownButton<TextAlign>(
          value: _currentTextAlign,
          items: TextAlign.values.map((e) => DropdownMenuItem(
            value: e, 
            child: Text(e.toString().split('.').last)
          )).toList(),
          onChanged: (newValue) {
            _currentTextAlign = newValue!;
            widget.textAlignValueChanged(newValue);
          }
        ),
        RoundCornerDropdownButton<TextColors>(
          value: _textColor,
          items: TextColors.values.map((e) => DropdownMenuItem(
            value: e,
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: e.color,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(16))
              )
            )
          )).toList(),
          onChanged: (newValue) {
            _textColor = newValue!;
            widget.textColorValueChanged(newValue.color);
          }
        )
      ]
    );
  }
}

enum TextColors { red, orange, yellow, green, cyan, blue, purple, white, black }

extension TextColorsExtension on TextColors {
  Color get color {
    switch (this) {
      case TextColors.red:
        return Colors.red;
      case TextColors.orange:
        return Colors.orange;
      case TextColors.yellow:
        return Colors.yellow;
      case TextColors.green:
        return Colors.green;
      case TextColors.cyan:
        return Colors.cyan;
      case TextColors.blue:
        return Colors.blue;
      case TextColors.purple:
        return Colors.purple;
      case TextColors.white:
        return Colors.white;
      case TextColors.black:
        return Colors.black;
    }
  }
}

class RoundCornerDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T value;

  RoundCornerDropdownButton({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.only(left: 4, right: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.green
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              value: value, items: items, onChanged: onChanged
          )
        )
      )
    );
  }
}
