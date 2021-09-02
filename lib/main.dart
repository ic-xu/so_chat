import 'dart:developer';
import 'dart:io';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/provider/message_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'chat/chat_message_list.dart';
import 'chat/webrtc/call_sample.dart';
import 'fitness_app/fitness_app_home_screen.dart';
import 'login/login_screen.dart';
import 'navigation_home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'introduction_animation/introduction_animation_screen.dart';
import 'package:event_bus/event_bus.dart' as events;

events.EventBus mainEventBus = events.EventBus();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome
      .setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ])
      .then((_) =>
      runApp(
        MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MessageEventBus()),
        ],
        child: MyApp(),
      ),));
  }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    // 全局配置子树下的SmartRefresher,下面列举几个特别重要的属性
   return RefreshConfiguration(
        headerBuilder: () => WaterDropHeader(),        // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
        footerBuilder:  () => ClassicFooter(),        // 配置默认底部指示器
        headerTriggerDistance: 80.0,        // 头部触发刷新的越界距离
        springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // 自定义回弹动画,三个属性值意义请查询flutter api
        maxOverScrollExtent :100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxUnderScrollExtent:50, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableLoadingWhenFailed : true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
       //以上是全局上拉刷新，下拉加载的全局属性配置，
        child: MaterialApp(
          //TODO 国际化



          title: 'Flutter UI',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: AppTheme.textTheme,
            platform: TargetPlatform.iOS,
          ),
          //导航主屏幕
          // home: FitnessAppHomeScreen(),

          // Navigator.of(context).push(MaterialPageRoute(
          //     builder:(context) => FitnessAppHomeScreen()
          // ));
          // home: NavigationHomeScreen(),

          //登录
          home: LoginScreen(),

          //webrtc
          // home: CallSample(host: "locahost"),


          // home: FitnessAppHomeScreen(),
          // EnmojApp(),
        )
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
