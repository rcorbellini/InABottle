import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:chameleon_resolver/chameleon_resolver.dart';
import 'package:in_a_bottle/_shared/route/navigator_di.dart';
import 'package:in_a_bottle/_shared/route/app_routes.dart';
import 'package:in_a_bottle/di/home_di.dart';
import 'package:in_a_bottle/home/widgets/home_widget.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart'
    as interface_navigator;
import 'package:in_a_bottle/local_message/hub/hub_message_di.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_di.dart';
import 'package:in_a_bottle/local_message/talk/talk_di.dart';
import 'package:in_a_bottle/di/treasure_hunt_di.dart';
import 'package:in_a_bottle/session/session_bloc.dart';
import 'package:in_a_bottle/features/session/session_di.dart';
import 'package:in_a_bottle/session/session_event.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/user/user_di.dart';
import 'package:in_a_bottle/user/widget/login_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heimdall/heimdall.dart';

void main() {
  Injector().initialiseAll([
    SessionDi(),
    HubMessageDI(),
    NavigatorDI(),
    TalkDi(),
    TreasureHuntDi(),
    UserDi(),
    DirectMessageDi(),
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
    final supportedLocale = <Locale>[const Locale('pt', 'BR')];
    return MaterialApp(
      title: 'In a Bottle',
      navigatorKey: DispatchRouter().navigatorKey,
      localizationsDelegates: [
        ChamaleonLocalizationsDelegate(
            flavorPrefix: null, supportedLocales: supportedLocale),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocale,
      localeResolutionCallback: localeResolutionCallback,
      onGenerateRoute: generateRoute,
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
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.white,
          cardColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xffEAECC6)),
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
