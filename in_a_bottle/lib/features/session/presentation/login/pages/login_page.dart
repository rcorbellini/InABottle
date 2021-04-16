import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_a_bottle/adapters/injection/base_injector.dart';
import 'package:in_a_bottle/features/session/domain/models/auth_user.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_bloc.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_event.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/button_google_auth_widget.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/objects_widget.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/sand_widget.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/waves_widget.dart';
import 'package:in_a_bottle/core/utils/string_ext.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BaseInjector().get<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        LoginPage2(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(children: [
                //todo need a logo here
                Text(
                  "loginPage.entrar".tr(context: context),
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                ButtonGoogleAuthWidget(
                  userResponse: dispatchLogin,
                )
              ]),
            ],
          ),
        )
      ],
    ));
  }

  void dispatchLogin(AuthUser? user) {
    _loginBloc.dispatchOn<LoginEvent>(LoggingByGoogle(user));
  }
}

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animValue;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..repeat(reverse: true);

    //CurveTween
    _animValue =
        Tween<double>(begin: 1.0, end: 200.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8D69F),
      body: Stack(
        children: [
          Sand(),
          Waves(animValue: _animValue),
          Floater(
            animValue: _animValue,
          ),
          Umbrella(
            animValue: _animValue,
          ),
        ],
      ),
    );
  }
}
