import 'package:dio/dio.dart';
import 'package:in_a_bottle/features/user/user.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  //} extends BaseRepository<User, String> {
  Future<String> login(User user);

  Future<User> loadByEmail(String email);
}

class UserDataRepository implements UserRepository {
  final Dio _dio;

  String baseUrl;

  UserDataRepository(this._dio, {this.baseUrl});

  @override
  Future<String> login(User entity) async {
    ArgumentError.checkNotNull(entity, 'entity');

    final Response _result = await _dio.post("/auth/google",
        data: entity.token ,
        options: RequestOptions(
            contentType: Headers.jsonContentType, baseUrl: baseUrl));
    return _result.data.toString();
  }

  @override
  Future<User> loadByEmail(String email) async{
    ArgumentError.checkNotNull(email, 'email');


    final Response _result = await _dio.get("/user/$email",
        options: RequestOptions(
            headers: {"Accept": "text/event-stream", "Cache-Control":"no-cache"},
            contentType: Headers.jsonContentType, baseUrl: baseUrl));
    print("teste");
    _result.data.listen((dynamic  teste){print(teste);});
    return User.fromJson(_result.data.data);
  }
}
