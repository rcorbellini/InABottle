import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_a_bottle/user/user.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class ButtonGoogleAuthWidget extends StatelessWidget {
  final UserResponse userResponse;

  const ButtonGoogleAuthWidget({Key? key, required this.userResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleSignInButton(
        splashColor: Colors.blue ,
        darkMode: true,
        onPressed: () async {
          try {
            final googleUser = await _googleSignIn.signIn();
            final user = User(
                token:  (await googleUser.authentication).idToken,
                name: googleUser.displayName,
                email: googleUser.email,
                photoUrl: googleUser.photoUrl);
            userResponse.call(user);
          } catch (ex) {
            print(ex);
            userResponse.call(null);
          }
        });
  }
}

typedef UserResponse = void Function(User? userFromIntegration);
