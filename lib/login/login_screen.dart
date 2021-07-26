import 'dart:async';
import 'dart:io';

import 'package:best_flutter_ui_templates/chat/chat_message_list.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import 'package:best_flutter_ui_templates/provider/message_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';


const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  '123@qq.com': '123',
};

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 10);

  late BuildContext? context;

  Future<String?> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
   var result = await Provider.of<MessageEventBus>(context!,listen: false)
       .login("172.20.73.88",data.name,data.password);
    if(!result){
      return Future.value("登录失败……,请检查用户名和密码！");
    }
    return Future.value(null);
  }

  Future<String?> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return FlutterLogin(
      title: 'MAX-HUB',
      logo: 'assets/images/inviteImage.png',
      onLogin: _authUser,
      onSignup: _authUser,
      userValidator: (_)=> null,
      userType: LoginUserType.name,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => FitnessAppHomeScreen(),
          // builder: (context) => ChatMessageList(),
        ));
      },
      messages: LoginMessages(
        userHint: '用户名',
        passwordHint: '密码',
        loginButton: '登录',
      ),
      onRecoverPassword: _recoverPassword,
    );
  }

}
