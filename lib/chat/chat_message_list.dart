import 'dart:ui';

import 'package:best_flutter_ui_templates/chat/chat_me_message_list_item.dart';
import 'package:best_flutter_ui_templates/chat/chat_message.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'chat_other_message_list_item.dart';

/// Example for EmojiPickerFlutter
class EnmojApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<EnmojApp> {
  List messageList = [];
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  late ScrollController _listController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    // _listController = new ScrollController();
    _listController.addListener(() {});
    messageList.addAll(_getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = window.physicalSize.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('XXXX'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Align(
              // 此处为关键代码
              alignment: Alignment.topCenter,
              //消息列表布局
              child: RefreshIndicator(
                onRefresh: _onRelush,
                child: ListView.builder(
                    reverse: false,
                    shrinkWrap: false,
                    controller: _listController,
                    itemCount: this.messageList.length,
                    itemBuilder: (context, index) {
                      ChatMessage message = this.messageList[index];
                      if (message.direction == 1) {
                        return ChatMeMessageListItem(message);
                      } else {
                        return ChatOtherMessageListItem(message);
                      }
                    }),
              ),
            )),

            //输入组件布局
            Container(
                height: 66.0,
                color: Colors.white,
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            emojiShowing = !emojiShowing;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: TextFormField(
                            controller: _controller,
                            maxLines: 2,
                            minLines: 1,
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black87,),
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 16.0,
                                  bottom: 1.0,
                                  top: 1.0,
                                  right: 16.0),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(20.0),
                              //   borderSide: BorderSide(color: Colors.red,width: 3.0,style: BorderStyle.solid),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            )),
                      ),
                    ),

                    //发送按钮
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: () {
                            //列表滚动到最下面
                            _listController.animateTo(
                                _listController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                            setState(() {
                              messageList.add(
                                  ChatMessage(_controller.value.text, 1, 1));
                            });

                            //  清空输入控件
                            _controller.clear();
                            // TODO send message
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.grey,
                          )),
                    )
                  ],
                )),

            //enmoj 布局
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                    onEmojiSelected: (Category category, Emoji emoji) {
                      _onEmojiSelected(emoji);
                    },
                    onBackspacePressed: _onBackspacePressed,
                    config: const Config(
                        columns: 7,
                        emojiSizeMax: 32.0,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        backspaceColor: Colors.blue,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecentsText: 'No Recents',
                        noRecentsStyle:
                            TextStyle(fontSize: 20, color: Colors.black26),
                        categoryIcons: CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _listController.dispose();
  }

  Future _onRelush() async {
    await Future.delayed(Duration(seconds: 3), () {
      print("object");
    });
  }

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  List<ChatMessage> _getData() {
    List<ChatMessage> list = [];

    return list;
  }
}
