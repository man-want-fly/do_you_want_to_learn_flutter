
import 'package:do_you_want_to_learn_flutter/widgets/basic/elements/widget_paint.dart';
import 'package:flutter/material.dart';

import 'basic_widget_element.dart';
import '/widgets/basic/elements/widget_checkbox.dart';
import '/widgets/basic/elements/widget_radio.dart';
import '/widgets/basic/elements/widget_form.dart';
import '/widgets/basic/elements/widget_switch.dart';
import '/widgets/basic/elements/widget_text.dart';
import '/widgets/basic/elements/widget_button.dart';
import '/widgets/basic/elements/widget_icon.dart';
import '/widgets/basic/elements/widget_image.dart';
import '/widgets/basic/elements/widget_row.dart';
import '/widgets/basic/elements/widget_infinity_list.dart';
import '/widgets/basic/elements/widget_textfield.dart';
import '/widgets/basic/elements/widget_todo.dart';

class WidgetWrapper extends StatelessWidget {
  WidgetWrapper({Key? key, required this.title, required this.element})
      : super(key: key);

  final String title;
  final BasicWidgetElement element;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)), body: _buildBody(element));
  }

  Widget _buildBody(BasicWidgetElement element) {
    switch (element) {
      case BasicWidgetElement.text:
        return WidgetText();
      case BasicWidgetElement.button:
        return WidgetButton();
      case BasicWidgetElement.image:
        return WidgetImage();
      case BasicWidgetElement.icon:
        return WidgetIcon();
      case BasicWidgetElement.textField:
        return WidgetTextField();
      case BasicWidgetElement.form:
        return WidgetForm();
      case BasicWidgetElement.theSwitch:
        return WidgetSwitch();
      case BasicWidgetElement.checkbox:
        return WidgetCheckbox();
      case BasicWidgetElement.radio:
        return WidgetRadio();
      case BasicWidgetElement.row:
        return WidgetRow();
      case BasicWidgetElement.infinityList:
        return WidgetInfinityList();
      case BasicWidgetElement.todoList:
        return TodoList();
      case BasicWidgetElement.Paint:
        return WidgetPaint();
      default:
        return Text('Coming soon...');
    }
  }
}
