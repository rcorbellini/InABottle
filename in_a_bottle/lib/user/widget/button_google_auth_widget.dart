import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_a_bottle/user/user_dto.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class ButtonGoogleAuthWidget extends StatelessWidget {
  final UserResponse userResponse;

  const ButtonGoogleAuthWidget({Key key, this.userResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () async {
          try {
            final googleUser = await _googleSignIn.signIn();
            final user = User(
                name: googleUser.displayName,
                email: googleUser.email,
                photoUrl: googleUser.photoUrl);
            userResponse?.call( user);
          } on Exception {
            userResponse?.call( null);
          }
        },
        child: const Text("Logar"));
  }
}

typedef UserResponse = void Function(User userFromIntegration);
