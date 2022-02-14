
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_channel_sample.dart';
import 'get_display_media_sample.dart';
import 'get_user_media_sample.dart';
import 'loopback_sample.dart';
import 'route_item.dart';

class WebRtcDemo extends StatefulWidget{
  _WebRtcDemo createState() => _WebRtcDemo();
}

class _WebRtcDemo extends State<WebRtcDemo>{
  late List<RouteItem> items;

  @override
  void initState() {
    super.initState();
    _initItems();
  }

  ListBody _buildRow(context, item) {
    return ListBody(children: <Widget>[
      ListTile(
        title: Text(item.title),
        onTap: () => item.push(context),
        trailing: Icon(Icons.arrow_right),
      ),
      Divider()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter-WebRTC example'),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              itemCount: items.length,
              itemBuilder: (context, i) {
                return _buildRow(context, items[i]);
              })),
    );
  }

  void _initItems() {
    items = <RouteItem>[
      RouteItem(
          title: 'GetUserMedia',
          push: (BuildContext context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => GetUserMediaSample()));
          }),
      RouteItem(
          title: 'GetDisplayMedia',
          push: (BuildContext context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        GetDisplayMediaSample()));
          }),
      RouteItem(
          title: 'LoopBack Sample',
          push: (BuildContext context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoopBackSample("0000")));
          }),
      RouteItem(
          title: 'DataChannel',
          push: (BuildContext context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DataChannelSample()));
          }),
    ];
  }
}