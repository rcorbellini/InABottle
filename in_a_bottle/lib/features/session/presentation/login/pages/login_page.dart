import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:in_a_bottle/adapters/injection/base_injector.dart';
import 'package:in_a_bottle/features/session/domain/models/auth_user.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_bloc.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_event.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/button_google_auth_widget.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/objects_widget.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/sand_widget.dart';
import 'package:in_a_bottle/features/session/presentation/login/pages/waves_widget.dart';

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
    //in test, new login
    return LoginPage2();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/waves_bg.png",
              fit: BoxFit.fill,
              height: 120,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/waves_bg.png",
              fit: BoxFit.fill,
              height: 105,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/waves_bg.png",
              fit: BoxFit.fill,
              height: 95,
            ),
          ),
          FlyCoins(),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0x552BC0E4), Color(0xaaEAECC6)])),
            child: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(children: [
                      Text(
                        "In A Bottle",
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey[800],
                      ),
                    ]),
                    ButtonGoogleAuthWidget(
                      userResponse: dispatchLogin,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dispatchLogin(AuthUser? user) {
    _loginBloc.dispatchOn<LoginEvent>(LoggingByGoogle(user));
  }
}

class FlyCoin extends StatelessWidget {
  final double animationValue;
  final double rotationScale;
  final Function getCurvePath;
  final Curve curve;

  const FlyCoin(
      {required this.animationValue,
      required this.getCurvePath,
      this.curve = Curves.linear,
      this.rotationScale = 1});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final dxPosition = Tween<double>(begin: -10, end: screenSize.width + 10)
        .transform(Interval(0, .9, curve: curve).transform(animationValue));
    final dyPosition =
        Tween<double>(begin: 0, end: pi * 2).transform(animationValue);

    final rotation = Tween<double>(begin: 0, end: 360)
        .transform(Curves.easeOutSine.transform(animationValue));

    return Positioned(
        child: Rotation3d(
            rotationY: rotation * rotationScale,
            rotationX: rotation * rotationScale,
            rotationZ: rotation * rotationScale,
            child: Image.asset("assets/images/coin.png",
                width: (screenSize.width * .015 + Random().nextDouble() * .01) +
                    10)),
        bottom: getCurvePath(dyPosition),
        left: dxPosition);
  }
}

class FlyCoins extends StatefulWidget {
  const FlyCoins();

  @override
  _FlyCoinsState createState() => _FlyCoinsState();
}

class _FlyCoinsState extends State<FlyCoins>
    with SingleTickerProviderStateMixin {
  static final Map<String, _FlyCoinsState> _cachedState = {};

  late Ticker _ticker;
  late double _animationValue;

  @override
  Widget build(BuildContext context) => Stack(children: <Widget>[
        FlyCoin(
            animationValue: _animationValue,
            rotationScale: 1.5,
            curve: Curves.easeInOutSine,
            getCurvePath: (double screenPosition) =>
                sin(screenPosition) * 15 + 200),
        FlyCoin(
            animationValue: _animationValue,
            rotationScale: 1.7,
            curve: Curves.easeOutQuad,
            getCurvePath: (double screenPosition) =>
                -cos(screenPosition) * 30 + 100),
        FlyCoin(
            animationValue: _animationValue,
            rotationScale: 1.7,
            curve: Curves.easeInQuad,
            getCurvePath: (double screenPosition) =>
                -cos(screenPosition) * 30 + 120),
        FlyCoin(
            animationValue: _animationValue,
            rotationScale: 1.2,
            curve: Curves.ease,
            getCurvePath: (double screenPosition) =>
                atan(screenPosition) * 10 + 150),
      ]);

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //Restore old state from the static cache, workaround because Hero causes our widget to lose state
    final prevState = _cachedState[widget.key.toString()];
    if (prevState != null) {
      _animationValue = prevState._animationValue;
    } else {
      _animationValue = 0;
    }
    //Replace cached state with ourselves
    _cachedState[widget.key.toString()] = this;

    _ticker = Ticker(_onTick)..start();
  }

  void _onTick(Duration d) {
    final speed = .001;
    setState(() {
      if (_animationValue + speed < 1) {
        _animationValue += speed;
      } else {
        _animationValue = 0;
      }
    });
  }
}

class Rotation3d extends StatelessWidget {
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  const Rotation3d(
      {required this.child,
      this.rotationX = 0,
      this.rotationY = 0,
      this.rotationZ = 0});

  @override
  Widget build(BuildContext context) => Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotationX * degrees2Radians)
        ..rotateY(rotationY * degrees2Radians)
        ..rotateZ(rotationZ * degrees2Radians),
      child: child);
}

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8D69F),
      body: Stack(
        children: [
          Sand(),
          Waves(),
          Floater(),
          Umbrella(),
        ],
      ),
    );
  }
}
