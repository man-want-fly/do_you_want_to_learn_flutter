import 'package:flutter/material.dart';

class WidgetDraggableScrollableSheet extends StatelessWidget {
  const WidgetDraggableScrollableSheet({
    Key? key, 
    required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          maxChildSize: 0.8,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16.0), 
                right: Radius.circular(16.0)
              )
            ),
            child: Column(
              children: [
                Container( // TODO: clip like clipToBounds
                  height: 64.0, width: double.infinity, 
                  color: Colors.blueGrey, 
                  child: Center(
                    child: Text(
                      'Title', 
                      style: TextStyle(color: Colors.white, fontSize: 24.0)
                    )
                  )
                ),
                Expanded(
                  child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (_, i) => ListTile(title: Text('item-$i')),
                  itemCount: 30
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}