import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters/injection/base_injector.dart';
import 'package:in_a_bottle/adapters/route/navigation_service.dart';
import 'package:in_a_bottle/core/adapters_di.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_bloc.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/login_page.dart';
import 'package:in_a_bottle/features/session/session_di.dart';

import 'adapters/route/app_routes.dart';

void main() {
  BaseInjector().initialiseAll([
    AdaptersDi(),
    SessionDi(),
    //HubMessageDI(),
    //NavigatorDI(),
    //TalkDi(),
    //TreasureHuntDi(),
    //UserDi(),
    //DirectMessageDi(),
    // HomeDi(),
  ]);
  return runApp(MyApp(loginBloc: BaseInjector().get<LoginBloc>()));
}

class MyApp extends StatelessWidget {
  final LoginBloc loginBloc;

  const MyApp({Key? key, required this.loginBloc}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final supportedLocale = <Locale>[const Locale('pt', 'BR')];
    return MaterialApp(
      title: 'In a Bottle',
      supportedLocales: supportedLocale,
      onGenerateRoute: generateRoute,
      key: NavigationServiceImp().navigatorKey,
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.white,
          cardColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xffEAECC6)),
      home: LoginPage(),
    );
  }
}
