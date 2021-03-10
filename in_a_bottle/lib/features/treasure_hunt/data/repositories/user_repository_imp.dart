

import 'package:in_a_bottle/features/treasure_hunt/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final http.Client client;

  String baseUrl;

  UserRepositoryImp(this.client, {required this.baseUrl});

  @override
  Future<String> login(User entity) async {
    ArgumentError.checkNotNull(entity, 'entity');

    var url =
    Uri.http(baseUrl, "/auth/google" );
    var request =http.Request("post", url);
    request.headers["Accept"] = "text/event-stream";
    request.headers["Cache-Control"] = "no-cache";
    var response =  client.send(request);

    response.then((streamedResponse) => streamedResponse.stream.listen((value) {
      final parsedData = utf8.decode(value);
      print(parsedData);

      //event:heartbeat
      //data:{"type":"heartbeat"}

      final eventType = parsedData.split("\n")[0].split(":")[1];
      print(eventType);
      //heartbeat
      final realParsedData = json.decode(parsedData.split("data:")[1]) as Map<String, dynamic>;
      if (realParsedData != null) {
        // do something
      }
    }, onDone: () => print("The streamresponse is ended"),),);


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