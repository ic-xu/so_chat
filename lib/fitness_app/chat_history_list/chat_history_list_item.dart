
import 'package:flutter/material.dart';

import '../fitness_app_theme.dart';



class ChatHistoryListItem extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Container(
      child:  Row(
        children: [
          Image.asset("assets/fitness_app/runner.png"),
          Text(
            "Keep it up\nand stick to your plan!tick to yourtick to yourtick to yourtick to yourtick to your",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 10,
              letterSpacing: 0.0,
              color: FitnessAppTheme.grey
                  .withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }




}