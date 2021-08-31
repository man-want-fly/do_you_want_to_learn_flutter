import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("AssetImage"),
            Image(
              image: AssetImage('images/watermelon.png'),
              loadingBuilder: (content, wgt, event) {
                if (event == null) { return wgt; }
                return Center(child: Text('Loading...'));
              },
              colorBlendMode: BlendMode.difference,
              repeat: ImageRepeat.repeatY,
              filterQuality: FilterQuality.low,
              fit: BoxFit.scaleDown,
            ),
            Divider(),
            Text("CachedNetworkImage"),
            CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: "https://img0.baidu.com/it/u=1618333087,978907067&fm=26&fmt=auto&gp=0.jpg",
            ),
          ],
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.all(16), 
      child: Image(
        image: AssetImage('images/watermelon.png'), 
        loadingBuilder: (content, wgt, event) {
          if (event == null) { return wgt; }
          return Center(child: Text('Loading...'));
        },
        colorBlendMode: BlendMode.difference,
        repeat: ImageRepeat.repeatY,
        filterQuality: FilterQuality.low,
        fit: BoxFit.scaleDown,
      )
    );
  }
}