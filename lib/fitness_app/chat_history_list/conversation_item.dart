import 'package:best_flutter_ui_templates/chat/widget/GStyle.dart';
import 'package:best_flutter_ui_templates/fitness_app/chat_history_list/model/conversation.dart';
import 'package:flutter/material.dart';

class ConversatonItem extends StatelessWidget {
  final Conversation? conversation;

  ConversatonItem(this.conversation);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  conversation!.avatar!,
                  height: 45,
                  width: 45,
                ),
                if (conversation!.unreadMsgCount > 0)
                  Positioned(
                    child: GStyle.badge(conversation!.unreadMsgCount),
                    top: -8,
                    right: -8,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation!.title!,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    Text(
                      conversation!.des!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                )),
          ),
          Column(
            children: [
              Text(
                conversation!.updateAt!,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
