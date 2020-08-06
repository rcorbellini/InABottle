import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/route/navigator_di.dart';
import 'package:in_a_bottle/home/home_di.dart';
import 'package:in_a_bottle/home/widgets/home_widget.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as interface_navigator;
import 'package:in_a_bottle/local_message/chat/chat_di.dart';
import 'package:in_a_bottle/local_message/message/message_di.dart';
import 'package:in_a_bottle/local_message/talk/talk_di.dart';
import 'package:in_a_bottle/session/session_bloc.dart';
import 'package:in_a_bottle/session/session_di.dart';
import 'package:in_a_bottle/session/session_event.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/user/user_di.dart';
import 'package:in_a_bottle/user/widget/login_widget.dart';

void main() {
  Injector().initialiseAll([
    SessionDi(),
    ChatDI(),
    NavigatorDI(),
    TalkDi(),
    UserDi(),
    MessageDi(),
    HomeDi(),
  ]);
  return runApp(MyApp(
    sessionBloc: Injector().get(),
  ));
}

class MyApp extends StatelessWidget {
  final SessionBloc sessionBloc;

  const MyApp({Key key, this.sessionBloc}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigator = Injector().get<interface_navigator.Navigator>();
    return MaterialApp(
      title: 'In a Bottle',
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
      home: StreamBuilder<SessionEvent>(
          stream: sessionBloc.streamOf<SessionEvent>(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            final event = snapshot.data;
            if (event is LoggedIn) {
              return HomeWidget();
            }

            return LoginWigdet();
          }),
    );
  }
}
