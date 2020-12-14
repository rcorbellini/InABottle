import 'package:dio/dio.dart';
import 'package:in_a_bottle/user/user.dart';

abstract class UserRepository {
  //} extends BaseRepository<User, String> {
  Future<String> login(User user);
}

class UserDataRepository implements UserRepository {
  final Dio _dio;

  String baseUrl;

  UserDataRepository(this._dio, {this.baseUrl});

  @override
  Future<String> login(User entity) async {
    ArgumentError.checkNotNull(entity, 'entity');

    final Response _result = await _dio.post("/user/login",
        data: entity.toMap() ?? <String, dynamic>{},
        options: RequestOptions(
            contentType: Headers.jsonContentType, baseUrl: baseUrl));
    return _result.data.toString();
  }
}
