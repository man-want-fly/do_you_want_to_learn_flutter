import 'package:flutter/material.dart';

class WidgetAnimatedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetAnimatedListState();
  }
}

class _WidgetAnimatedListState extends State<WidgetAnimatedList>
    with SingleTickerProviderStateMixin {
  List<int> _list = [0, 1, 2];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addItem() {
    final int index = _list.length;
    _list.insert(index, index);
    _listKey.currentState?.insertItem(index);
  }

  void _removeItem() {
    final int index = _list.length - 1;
    if (index >= 0) {
      var item = _list[index].toString();
      _listKey.currentState?.removeItem(
          index, (context, animation) => _buildItem(item, animation));
      _list.removeAt(index);
    }
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SlideTransition(
      position: animation
          .drive(CurveTween(curve: Curves.easeIn))
          .drive(Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))),
      child: Card(
        child: ListTile(
          title: Text(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return _buildItem(_list[index].toString(), animation);
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _addItem,
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  onPressed: _removeItem,
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
