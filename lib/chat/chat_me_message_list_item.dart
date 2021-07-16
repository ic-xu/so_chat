import 'package:best_flutter_ui_templates/chat/chat_message.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMeMessageListItem extends StatelessWidget{

  ChatMessage message;

  ChatMeMessageListItem(this.message);

  @override
  Widget build(BuildContext context) {

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        // Stack(
        //
        //     children: [
        //       CircleAvatar(
        //         // child: Image.network("https://img-blog.csdnimg.cn/img_convert/3951983a356a18f1991c9151e0877957.png",fit: BoxFit.contain,),
        //         // radius: 30.0,
        //         foregroundImage: NetworkImage(
        //             "https://img-blog.csdnimg.cn/img_convert/3951983a356a18f1991c9151e0877957.png"),
        //       ),
        //     ]),
        Expanded(
          child: Bubble(
            margin: BubbleEdges.only(top: 20,left: 50),
            padding: BubbleEdges.all(15),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightBottom,
            nipOffset: 25,
            radius: Radius.circular(10.0),
            color: Color.fromARGB(255, 225, 255, 199),
            child: Text(message.message,style: TextStyle(fontSize: 18),),
          ),

          // Container(
          //   child: Text(message.message,
          //     style: Theme.of(context).textTheme.bodyText1,
          //     overflow: TextOverflow.fade,
          //   ),
          //   margin: EdgeInsets.only(
          //       left: 50, top: 10, right: 0, bottom: 10),
          //   padding: EdgeInsets.all(15),
          //   decoration: BoxDecoration(
          //       color: Colors.grey,
          //       borderRadius:
          //       new BorderRadius.circular(10.0)),
          // ),
        ),
      ],
    );
  }


}