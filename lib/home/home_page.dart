import 'package:best_flutter_ui_templates/fitness_app/chat_history_list/chat_history_list.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/training/training_screen.dart';
import 'package:best_flutter_ui_templates/hotel_booking/filters_screen.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_home_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../navigation_home_screen.dart';
import 'data.dart';
import 'model/choice_value.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageScreenStatus();
}

class _HomePageScreenStatus extends State<HomePageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  AnimationController? animationController;

  static final kTabTypes = [
    ChoiceValue<List<TabItem>>(
      title: 'Icon Tab',
      label: 'Appbar use icon with Tab',
      value: Data.items(image: false),
    ),
    ChoiceValue<List<TabItem>>(
      title: 'Image Tab',
      label: 'Appbar use image with Tab',
      value: Data.items(image: true),
    ),
  ];

  var _tabItems = kTabTypes.first;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabItems.value.length, vsync: this);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
  }

  List<Widget> getView() {
    var views = <Widget>[];
    views.add(NavigationHomeScreen());
    views.add(FitnessAppHomeScreen());
    views.add(TrainingScreen(animationController: animationController));

    views.add(ChatHistoryListScreen(animationController: animationController));

    views.add(HotelHomeScreen());

    return views;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: TabBarView(controller: _tabController, children: getView()),
          bottomNavigationBar: ConvexAppBar.badge(
            {3: "99+", 4: Icons.assistant_photo, 2: Colors.redAccent},
            badgeBorderRadius: 2,
            backgroundColor: FitnessAppTheme.background,
            // badgePadding: EdgeInsets.only(left: 7, right: 7),
            badgeMargin: EdgeInsets.only(bottom: 35, left: 35),
            items: _tabItems.value,
            color: FitnessAppTheme.darkerText,
            activeColor: FitnessAppTheme.nearlyDarkBlue,
            controller: _tabController,
            initialActiveIndex: 2,
            //optional, default as 0
            onTap: (int i) => {
              print('click index=$i'),
            },
          )),
    );
  }
}
