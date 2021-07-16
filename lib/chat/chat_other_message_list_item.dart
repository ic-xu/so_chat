
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'chat_message.dart';


class ChatOtherMessageListItem extends StatelessWidget{
  ChatMessage message;

  ChatOtherMessageListItem(this.message);

  @override
  Widget build(BuildContext context) {

    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Stack(children: [
          CircleAvatar(
            // child: Image.network("https://img-blog.csdnimg.cn/img_convert/3951983a356a18f1991c9151e0877957.png",fit: BoxFit.contain,),
            // radius: 30.0,
            foregroundImage: NetworkImage(
                "https://img-blog.csdnimg.cn/img_convert/3951983a356a18f1991c9151e0877957.png"),
          ),
        ]),

        Expanded(
          child: Bubble(
            margin: BubbleEdges.only(top: 20,right: 50),
            padding: BubbleEdges.all(15),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftCenter,
            color: Color.fromARGB(100, 88, 220, 220),
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

        // Expanded(
        //   child: Container(
        //     child: Text(message.message,
        //       style: Theme.of(context).textTheme.bodyText1,
        //       overflow: TextOverflow.fade,
        //     ),
        //     padding: EdgeInsets.all(15),
        //     margin: EdgeInsets.only(
        //         left: 1, top: 10, right: 50, bottom: 10),
        //     decoration: BoxDecoration(
        //         color: Colors.blue,
        //         borderRadius:
        //         new BorderRadius.circular(10.0)),
        //   ),
        // )
      ],
    );
  }



}