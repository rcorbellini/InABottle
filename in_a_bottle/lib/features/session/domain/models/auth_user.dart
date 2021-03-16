import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String? displayName;
  final String? email;
  final String token;
  final String? photoUrl;

  AuthUser({required this.displayName, required this.email, required this.token, this.photoUrl});

  @override
  List<Object> get props {
    return [
      displayName,
      email,
      token,
      photoUrl??'',
    ];
  }
}