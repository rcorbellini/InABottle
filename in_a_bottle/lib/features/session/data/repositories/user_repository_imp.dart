

import 'package:in_a_bottle/features/session/data/data_sources/user_remote_data_source.dart';
import 'package:in_a_bottle/features/session/domain/models/user.dart';
import 'package:in_a_bottle/features/session/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImp({required this.remote});

  @override
  Stream<User> loadByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Stream<String> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Stream<User> loginByGoogle(String token) {
    return remote.authByGoogle(token);
  }

  
}