import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class BasicNetworking1 extends StatefulWidget {
  const BasicNetworking1({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  createState() => _BasicNetwork1State();
}

class _BasicNetwork1State extends State<BasicNetworking1> {

  late Future<List<_Post>> _posts;

  @override
  void initState() {
    super.initState();
    //  Future.delayed(Duration(seconds: 3), () {
    //    setState(() {
         _posts = _fetchPosts();
    //    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<_Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<_Post> items = snapshot.data ?? [];
            return ListView.separated(
              separatorBuilder: (_, x) => Divider(),
              itemCount: items.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(items[i].title),
                subtitle: Text(items[i].body)
              )
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  Future<List<_Post>> _fetchPosts() async {
    // sleep(Duration(seconds: 2));
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      List listResponse = jsonDecode(response.body);
      return listResponse.map((e) => _Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed fetch data');
    }
  }
}

class _Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  _Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });

  factory _Post.fromJson(Map<String, dynamic> json) => _Post(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body']
  );
}