import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todoList = <String>[];
  final _doneList  = <String>[];
  final _controller = TextEditingController();

  void addTodo() {
    if( _controller.text.length == 0) return;
    setState(() {
      _todoList.add(_controller.text);
      _controller.text = '';
    });
  }
  
  void deleteTodo(index) {
    setState(() {
      print(index);
      _todoList.removeAt(index);
    });
  }

  void addDone(index) {
    setState(() {
      _doneList.add(_todoList[index]);
    });
    deleteTodo(index);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.text);
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Expanded(
              child: ListView.separated(
            itemCount: _todoList.length,
            separatorBuilder: (context, idx) => Divider(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  IconButton(onPressed: () => deleteTodo(index), icon: Icon(Icons.task_alt)),
                  Expanded(child: Text(_todoList[index])),
                  IconButton(onPressed: () => deleteTodo(index), icon: Icon(Icons.cancel))
                ],
              );
            },
          )),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '增加 Todo',
                    ),
                    controller: _controller,
                    onSubmitted: (value) => addTodo(),
                  ),
                ),
                TextButton(onPressed: addTodo, child: Text("添加"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
