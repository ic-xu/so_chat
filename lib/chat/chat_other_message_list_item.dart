import 'package:best_flutter_ui_templates/fitness_app/chat_history_list/model/conversation.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'chat_message.dart';

class ChatOtherMessageListItem extends StatelessWidget {
  ChatMessage message;

  Conversation conversation;

  ChatOtherMessageListItem(this.message, this.conversation);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Stack(children: [
            CircleAvatar(
              // child: Image.network("https://img-blog.csdnimg.cn/img_convert/3951983a356a18f1991c9151e0877957.png",fit: BoxFit.contain,),
              radius: 15.0,
              foregroundImage: NetworkImage(conversation.avatar!),
            ),
          ]),

          Expanded(
            child: Bubble(
              margin: BubbleEdges.only(top: 20, right: 50),
              padding: BubbleEdges.all(10),
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftCenter,
              nipOffset: -10,
              radius: Radius.circular(20.0),
              color: Color.fromARGB(100, 88, 220, 220),
              child: Text(
                message.message,
                style: TextStyle(fontSize: 17),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
