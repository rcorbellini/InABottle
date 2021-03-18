import 'package:in_a_bottle/features/session/domain/models/user.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Stream<User> authByGoogle(String token);
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  UserRemoteDataSourceImp({required this.client});

  final http.Client client;

  @override
  Stream<User> authByGoogle(String token) async* {
    final response = await client.post(
        Uri.parse("http://47a3d1e24e07.ngrok.io/auth/google/"),
        headers: {'content-type': 'application/json'},
        body: token);

    print(response.body);

    yield User();
  }
}
