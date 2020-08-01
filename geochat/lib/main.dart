import 'package:flutter/material.dart';
import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/route/navigator_di.dart';
import 'package:geochat/home/home_di.dart';
import 'package:geochat/home/home_widget.dart';
import 'package:geochat/_shared/route/navigator.dart' as interface_navigator;
import 'package:geochat/local_message/chat/chat_di.dart';
import 'package:geochat/local_message/message/message_di.dart';
import 'package:geochat/local_message/talk/talk_di.dart';

void main() {
  Injector().initialiseAll([
    ChatDI(),
    NavigatorDI(),
    TalkDi(),
    MessageDi(),
    HomeDi(),
  ]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigator = Injector().get<interface_navigator.Navigator>();
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigator.navigatorKey,
      onGenerateRoute: navigator.buildRouteFactory(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeWidget(),
    );
  }
}
