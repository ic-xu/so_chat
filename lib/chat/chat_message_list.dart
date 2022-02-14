import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:best_flutter_ui_templates/chat/chat_me_message_list_item.dart';
import 'package:best_flutter_ui_templates/chat/chat_message.dart';
import 'package:best_flutter_ui_templates/connect_manager/connect_socket_manager.dart';
import 'package:best_flutter_ui_templates/fitness_app/chat_history_list/model/conversation.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'chat_other_message_list_item.dart';

/// Example for EmojiPickerFlutter
class ChatMessageList extends StatefulWidget {
  final Conversation conversation;
  final String toUserName;

  ChatMessageList(this.conversation, this.toUserName);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ChatMessageList> with WidgetsBindingObserver {
  List messageList = [];
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  late ScrollController _listController = new ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    // _listController = new ScrollController();

    _listController.addListener(() {});
    // messageList.reversed;
    messageList.addAll(_getData());
    messageList = messageList.reversed.toList();
    _updateMessageList();
    super.initState();
    //初始化
    WidgetsBinding.instance!.addObserver(this);
  }

  _updateMessageList() {
    mainEventBus.on<MqttCustomerMessage>().listen((mqttCustomerMessage) {
      if (mqttCustomerMessage.messageType == 21) {
        String messageString =
            utf8.decoder.convert(mqttCustomerMessage.payload.message!.toList());
        ChatMessage receiverMessage = ChatMessage.fromJson(messageString);
        receiverMessage.direction = 0;
        setState(() {
          messageList.insert(0,receiverMessage);
        });
      }
    });
  }

  // @override
  // void didChangeDependencies() {
  //   _updateMessageList();
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  void deactivate() {
    // TODO: implement deactivate

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // resizeToAvoidBottomInset: false, //只要子组件需要监听键盘高度  父组件的所有该属性都应该设置false
        appBar: AppBar(
          backgroundColor: FitnessAppTheme.background,
          title: Text(
            widget.conversation.title!,
            style: TextStyle(color: FitnessAppTheme.deactivatedText),
          ),
          leading: SizedBox(
            height: 38,
            width: 38,
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: FitnessAppTheme.deactivatedText,
                ),
              ),
            ),
          ),
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
                    reverse: true,
                    shrinkWrap: true,
                    controller: _listController,
                    itemCount: this.messageList.length,
                    itemBuilder: (context, index) {
                      ChatMessage message = this.messageList[index];
                      if (message.direction == 1) {
                        return ChatMeMessageListItem(
                            message, widget.conversation);
                      } else {
                        return ChatOtherMessageListItem(
                            message, widget.conversation);
                      }
                    }),
              ),
            )),

            Container(
              height: 5,
            ),
            //输入组件布局
            Container(
                height: 66.0,
                color: FitnessAppTheme.white,
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _focusNode.unfocus();
                            emojiShowing = !emojiShowing;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Focus(
                          child: TextFormField(
                              controller: _controller,
                              focusNode: _focusNode,
                              maxLines: 2,
                              minLines: 1,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: FitnessAppTheme.darkerText,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                filled: true,
                                fillColor: FitnessAppTheme.white,
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
                          onFocusChange: (focus) {
                            if (focus) {
                              setState(() {
                                emojiShowing = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    //发送按钮
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: () {
                            //列表滚动到最下面
                            _listController.animateTo(
                                _listController.position.minScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                            String sendText = _controller.value.text;
                            // ignore: unnecessary_null_comparison
                            if (null == sendText.trim() ||
                                sendText.trim().length == 0) {
                              return;
                            }

                            var message =
                                ChatMessage(sendText, 1, 1, widget.toUserName);
                            setState(() {
                              // _getData().add(message);
                              messageList.insert(0, message);
                            });

                            //  清空输入控件
                            _controller.clear();
                            // TODO send message
                            ConnectionManager.getInstance()
                                .sendChatMessage(message);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: FitnessAppTheme.grey,
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
                        emojiSizeMax: 32 * 1.30,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: FitnessAppTheme.white,
                        indicatorColor: FitnessAppTheme.nearlyDarkBlue,
                        iconColor: FitnessAppTheme.grey,
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
    //销毁
    WidgetsBinding.instance!.removeObserver(this);
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
    for (int i = 0; i < 50; i++) {
      list.add(ChatMessage(
          "$i m sadfasdf sdafas d 哈哈 😄 爱上 gga 哈哈哈  阿苏哈哈啥地方阿静说的话将"
              "阿什顿发阿克苏鲁返回阿斯科利绝代风华阿斯科利地方阿克里斯朵夫阿克苏鲁吧essage",
          1,
          i % 2,
          "xxxx"));
    }
    return list;
  }
}
