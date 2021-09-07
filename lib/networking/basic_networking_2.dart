import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class BasicNetworking2 extends StatefulWidget {
  const BasicNetworking2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BasicNetworking2State createState() => _BasicNetworking2State();
}

class _BasicNetworking2State extends State<BasicNetworking2> {
  late Future<List<_Related>> _relateds;

  @override
  void initState() {
    super.initState();
    _relateds = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<_Related>>(
        future: _relateds,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, i) {
                final item = snapshot.data![i];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(item.user.profileImages[ProfileImageKey.large]!)),
                      title: Text(item.user.username, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: item.user.bio != null ? Text(item.user.bio!, style: TextStyle(color: Colors.black)) : null,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 66.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            padding: EdgeInsets.only(left: 4.0, right: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                            ),
                            child: Text(
                              item.displayingCreatedAt,
                              style: TextStyle(color: Colors.black54)
                            )
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage( // FIXME: why reloaded when scrolling
                              imageUrl: item.urls![_ReleatedURLKey.raw]!,
                              // imageBuilder: (context, provider) => Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.all(Radius.circular(16.0)),
                              //     image: DecorationImage(image: provider)
                              //   ),
                              // ),
                              placeholder: (_, x) => Center(child: CircularProgressIndicator()),
                              errorWidget: (_, x, y) => Icon(Icons.error),
                              alignment: Alignment.topLeft,
                              fit: BoxFit.fill,
                              width: _imageDisplayWidth(context),
                              height: _imageDisplayHeight(item.width, item.height, _imageDisplayWidth(context)),
                            )
                          )
                        ]
                      )
                    )
                  ]
                );
              },
              separatorBuilder: (_, x) => Divider(),
              itemCount: snapshot.data!.length);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  double _imageDisplayWidth(BuildContext context) =>
    MediaQuery.of(context).size.width - 66.0 - 16.0 - 8.0;

  double _imageDisplayHeight(int ow, int oh, double rw) => rw * oh / ow;

  Future<List<_Related>> _fetchData() async {
    final resp = await http
        .get(Uri.parse('https://unsplash.com/napi/photos/Q14J2k8VE3U/related'));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(resp.body);
      final total = body['total'];
      print('total count: --- $total');
      final List results = body['results'];
      final items = results.map((e) => _Related.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('Failed fetch data');
    }
  }
}

// TODO: code generator

class _Related {
  _Related({
    required this.id,
    required String createdAt,
    this.description,
    required this.width,
    required this.height,
    this.urls,
    this.links,
    required this.categories,
    required this.likes,
    required this.likedByUser,
    required this.user
  }) : _createdAt = createdAt;

  factory _Related.fromJson(Map<String, dynamic> json) {
    final jsonLikes = json['urls'].cast<String, String>();
    Map<_ReleatedURLKey, String> urls = Map();
    urls[_ReleatedURLKey.raw] = jsonLikes['raw']!;
    urls[_ReleatedURLKey.small] = jsonLikes['small']!;

    final jsonLinks = Map<String, String>.from(json['links']);
    Map<_ReleatedLinkKey, String> links = Map();
    links[_ReleatedLinkKey.self] = jsonLinks['self'] as String;
    links[_ReleatedLinkKey.download] = jsonLinks['download'] as String;

    return _Related(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      description: json['description'] as String?,
      width: json['width'],
      height: json['height'],
      urls: urls,
      links: links,
      categories: List<String>.from(json['categories']),
      likes: json['likes'] as int,
      likedByUser: json['liked_by_user'] as bool,
      user: _User.fromJson(json['user'])
    );
  }

  final String id;
  final String _createdAt;
  final String? description;
  final int width, height;
  final Map<_ReleatedURLKey, String>? urls;
  final Map<_ReleatedLinkKey, String>? links;

  final List<String> categories;
  final int likes;
  final bool likedByUser;
  final _User user;

  String get displayingCreatedAt => DateFormat.yMMMMEEEEd().format(DateTime.parse(_createdAt));
}

enum _ReleatedURLKey { raw, small }

enum _ReleatedLinkKey { self, download }

class _User {
  _User({
    required this.id,
    required this.username,
    required this.name,
    this.portfolioURL,
    this.bio,
    this.location,
    required this.profileImages
  });

  factory _User.fromJson(Map<String, dynamic> json) {
    final jsonProfileImages = Map<String, String>.from(json['profile_image']);
    Map<ProfileImageKey, String?> profileImages = Map();
    profileImages[ProfileImageKey.small] = jsonProfileImages['small'];
    profileImages[ProfileImageKey.medium] = jsonProfileImages['medium'];
    profileImages[ProfileImageKey.large] = jsonProfileImages['large'];
    return _User(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      portfolioURL: json['portfolio_url'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      profileImages: profileImages
    );
  }

  final String id;
  final String username;
  final String name;
  final String? portfolioURL;
  final String? bio;
  final String? location;
  final Map<ProfileImageKey, String?> profileImages;
}

enum ProfileImageKey {
  small, medium, large
}
