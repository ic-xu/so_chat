import 'dart:async';
import 'dart:convert';

import 'package:best_flutter_ui_templates/chat/chat_message_list.dart';
import 'package:best_flutter_ui_templates/connect_manager/connect_socket_manager.dart';
import 'package:best_flutter_ui_templates/fitness_app/chat_history_list/model/conversation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../main.dart';
import 'loopback_sample.dart';

class OneToOne extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OneToOneState();
}

class _OneToOneState extends State<OneToOne> {
  List<String> dataList = [];

  var timeout = const Duration(seconds: 10);


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer.periodic(timeout, (timer) { //callback function
      //1s 回调一次
      print('afterTimer=' + DateTime.now().toString());
      _sendMessage();
      // timer.cancel(); // 取消定时器
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  void _sendMessage() async {
    final builder = MqttClientPayloadBuilder();
    builder.addUTF8String("listClientIds");
    var message = MqttCustomerMessage(0, builder.payload);
    ConnectionManager.getInstance().sendCustomerMessage(message);
  }

  @override
  void didChangeDependencies() {
    mainEventBus.on<MqttCustomerMessage>().listen((message) {
      if (message.messageType == 0) {
        String messageString =
        utf8.decoder.convert(message.payload.message!.toList());
        List remoteMessageList = jsonDecode(messageString);
        setState(() {
          dataList = remoteMessageList.map((e) => e.toString()).toList();
        });
      }
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('One To One Chat')),
      body: Container(
          child: new ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListBody(children: <Widget>[
                  ListTile(
                    title: Text(dataList[index]),
                    onTap: null,
                    trailing: SizedBox(
                        width: 150.0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.message),
                                onPressed: () =>
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            Conversation conversation =  Conversation(
                                              avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
                                              title: 'Tina Morgan',
                                              des: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
                                              updateAt: '17:58',
                                              isMute: false,
                                              unreadMsgCount: 3,
                                            );
                                            return ChatMessageList(conversation,dataList[index]);
                                          }
                                      ))
                                },
                                tooltip: 'Video calling',
                              ),
                              IconButton(
                                icon: const Icon(Icons.videocam),
                                onPressed: () =>
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoopBackSample(dataList[index])))
                                },
                                tooltip: 'Video calling',
                              ),
                              IconButton(
                                icon: const Icon(Icons.screen_share),
                                onPressed: () => {},
                                tooltip: 'Screen sharing',
                              )
                            ])),
                  ),
                  Divider()
                ]);
              })),
    );
  }
}
