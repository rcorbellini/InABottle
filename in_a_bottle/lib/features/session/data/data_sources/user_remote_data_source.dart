import 'package:in_a_bottle/adapters/network/sse.dart';
import 'package:in_a_bottle/core/app_config.dart';
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
    Uri uri = Uri.http(baseUrl, '/auth/google/');


    EventSource(uri)
    final response = await client.post(uri,
        headers: {'content-type': 'application/json'}, body: token);

    print(response.body);

    yield User();
  }
}
