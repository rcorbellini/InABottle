import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';

import 'package:fancy_stream/fancy_stream.dart';

import 'package:in_a_bottle/user/login_bloc.dart';
import 'package:in_a_bottle/user/login_event.dart';
import 'package:in_a_bottle/user/user_dto.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email','https://www.googleapis.com/auth/contacts.readonly',    
  ],
);

class LoginWigdet extends StatefulWidget {
  @override
  _LoginWigdetState createState() => _LoginWigdetState();
}

class _LoginWigdetState extends State<LoginWigdet> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = Injector().get<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          onPressed: () async {
            try {
              //final teste = await _googleSignIn.signIn();
              _loginBloc.dispatchOn<LoginEvent>(Logging(User(name: "teste")));
            } on Error catch (error) {
              print(error);
            }
          },
          child: const Text("Logar")),
    );
  }
}
