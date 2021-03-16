
import 'package:in_a_bottle/adapters/network/http_client.dart';
import 'package:in_a_bottle/features/session/domain/models/user.dart';

abstract class UserRemoteDataSource{
  Stream<User> authByGoogle(String token);
}

class UserRemoteDataSourceImp extends UserRemoteDataSource{
  UserRemoteDataSourceImp({required this.http2client});

  final Http2Client http2client;


  @override
  Stream<User> authByGoogle(String token) async*{
    http2client.stream(RequestHttp2(
      uri: Uri.parse(""),
      method: 'GET',
      headers: {}
    ));
  }

}