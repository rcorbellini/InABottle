import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/session_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/session_event.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/login_page.dart';
import 'package:in_a_bottle/features/session/session_di.dart';

import 'adapters/route/app_routes.dart';

void main() {
  Injector().initialiseAll([
    SessionDi(),
    //HubMessageDI(),
    //NavigatorDI(),
    //TalkDi(),
    //TreasureHuntDi(),
    //UserDi(),
    //DirectMessageDi(),
    // HomeDi(),
  ]);
  return runApp(MyApp(
    sessionBloc: Injector().get(),
  ));
}

class MyApp extends StatelessWidget {
  final SessionBloc sessionBloc;

  const MyApp({Key? key, required this.sessionBloc}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final supportedLocale = <Locale>[const Locale('pt', 'BR')];
    return MaterialApp(
      title: 'In a Bottle',
      supportedLocales: supportedLocale,
      onGenerateRoute: generateRoute,
      theme: ThemeData(
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
              return LoginPage();
            }

            return LoginPage();
          }),
    );
  }
}
