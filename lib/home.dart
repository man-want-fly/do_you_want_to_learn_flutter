import 'package:do_you_want_to_learn_flutter/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)), 
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    return Align(
      alignment: AlignmentDirectional.center, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Image.asset('images/watermelon.png', width: 240),
          Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Do you want to learn Flutter?', 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 44))
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => WidgetsPage())
                );
              }, 
              child: Text('Yes')
            )
          )
        ]
      )
    );
  }
}
