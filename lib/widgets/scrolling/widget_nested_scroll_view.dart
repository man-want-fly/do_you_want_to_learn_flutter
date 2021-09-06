import 'dart:math';

import 'package:flutter/material.dart';

class WidgetNestedScrollView extends StatefulWidget {
  const WidgetNestedScrollView({ Key? key }) : super(key: key);

  @override
  _WidgetNestedScrollViewState createState() => _WidgetNestedScrollViewState();
}

class _WidgetNestedScrollViewState extends State<WidgetNestedScrollView> {

  final _tabs = ['one', 'two', 'three', 'four', 'five', 'six', 'seven'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nested ScrollView')),
      body: DefaultTabController(
        initialIndex: 1,
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: Icon(Icons.list),
                title: Text('Test'),
                expandedHeight: 200.0,
                pinned: true,
                floating: true,
                // snap: ,
                flexibleSpace: FlexibleSpaceBar(
                  // centerTitle: true,
                  // title: Text('abc'),
                  background: Container(width: double.maxFinite, height: 200.0, color: Colors.cyan)
                ),
                bottom: TabBar(
                  tabs: _tabs.map((e) => Tab(text: e)).toList(),
                  indicatorColor: Colors.white,
                  indicatorWeight: 8.0,
                  isScrollable: true
                ),
              )
            )
          ],
          body: TabBarView(
            children: _tabs.map((e) => Container(
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5)
            )).toList()
          )
        ),
      )
    );
  }
}

