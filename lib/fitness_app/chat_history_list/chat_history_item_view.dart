import 'package:flutter/material.dart';
import '../fitness_app_theme.dart';

class ChatHistoryItemView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ChatHistoryItemView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.4),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              child: SizedBox(
                                height: 60,
                                child: AspectRatio(
                                  aspectRatio: 1.714,
                                  child: Image.asset(
                                      "assets/fitness_app/back.png"),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 80,
                                        right: 80,
                                        top: 5,
                                      ),

                                      child: Text(
                                        "You're doing great!",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily:
                                          FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: FitnessAppTheme
                                              .nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 80,
                                    top: 5,
                                    right: 50,
                                  ),
                                  child: Text(
                                    "Keep it up and stick to your plan plan!tick to yourtick to yourtick  plan!tick to yourtick to yourtick  plan!tick to yourtick to yourtick  plan!tick to yourtick to yourtick  plan!tick to yourtick to yourtick  plan!tick to yourtick to yourtick !tick to yourtick to yourtick to yourtick to yourtick to your",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      letterSpacing: 0.0,
                                      color: FitnessAppTheme.grey
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -0,
                      left: 0,
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset("assets/fitness_app/runner.png"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
