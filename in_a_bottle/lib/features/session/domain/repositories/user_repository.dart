
import 'package:in_a_bottle/features/session/domain/models/user.dart';

abstract class UserRepository {
  Stream<String> login(String email,  String password);

  Stream<User> loginByGoogle(String token);

  Stream<User> loadByEmail(String email);
}
