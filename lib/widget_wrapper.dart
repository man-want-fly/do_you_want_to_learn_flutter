import 'package:do_you_want_to_learn_flutter/widgets/widget_checkbox.dart';
import 'package:do_you_want_to_learn_flutter/widgets/widget_form.dart';
import 'package:do_you_want_to_learn_flutter/widgets/widget_radio.dart';
import 'package:do_you_want_to_learn_flutter/widgets/widget_switch.dart';
import 'package:flutter/material.dart';

import 'widget_element.dart';
import 'widgets/widget_text.dart';
import 'widgets/widget_button.dart';
import 'widgets/widget_icon.dart';
import 'widgets/widget_image.dart';
import 'widgets/widget_row.dart';
import 'widgets/widget_infinity_list.dart';
import 'widgets/widget_textfield.dart';
import 'widgets/widget_todo.dart';

class WidgetWrapper extends StatelessWidget {
  WidgetWrapper({Key? key, required this.title, required this.element})
      : super(key: key);

  final String title;
  final WidgetElement element;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)), body: _buildBody(element));
  }

  Widget _buildBody(WidgetElement element) {
    switch (element) {
      case WidgetElement.text:
        return WidgetText();
      case WidgetElement.button:
        return WidgetButton();
      case WidgetElement.image:
        return WidgetImage();
      case WidgetElement.icon:
        return WidgetIcon();
      case WidgetElement.textField:
        return WidgetTextField();
      case WidgetElement.form:
        return WidgetForm();
      case WidgetElement.theSwitch:
        return WidgetSwitch();
      case WidgetElement.checkbox:
        return WidgetCheckbox();
      case WidgetElement.radio:
        return WidgetRadio();
      case WidgetElement.row:
        return WidgetRow();
      case WidgetElement.infinityList:
        return WidgetInfinityList();
      case WidgetElement.todoList:
        return TodoList();
      default:
        return Text('Coming soon...');
    }
  }
}
