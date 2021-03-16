import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_a_bottle/features/session/domain/models/auth_user.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class ButtonGoogleAuthWidget extends StatelessWidget {
  final AuthResponse userResponse;

  const ButtonGoogleAuthWidget({Key? key, required this.userResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text("Google"),
        onPressed: () async {
          try {
            final googleUser = await _googleSignIn.signIn();
            if (googleUser == null) {
              userResponse.call(null);
              return;
            }
            final user = AuthUser(
                token: (await googleUser.authentication).idToken!,
                displayName: googleUser.displayName,
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

typedef AuthResponse = void Function(AuthUser? token);
