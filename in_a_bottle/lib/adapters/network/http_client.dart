import 'package:http/http.dart' as http;

class RequestHttp2 {
  final Uri uri;
  final String method;
  final Map<String, String> headers;
  final Object? data;

  RequestHttp2(
      {required this.uri,
      required this.method,
      required this.headers,
      required this.data});
}

abstract class Http2Client {
  Stream<String> stream(RequestHttp2 requestHttp2);
}



class ClientHttp extends http.BaseClient implements http.Client {
  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final defaultHeaders = _getDefaultHeaders();
    if (defaultHeaders != null) {
      request.headers.addAll(defaultHeaders);
    }
    return _httpClient.send(request);
  }

  Map<String, String>? _getDefaultHeaders() {
    return null;
    /*final session = SessionHolder();
    final client = session.client;
    final uid = session.uid;
    final acessToken = session.accessToken;

    if (client == null || uid == null || acessToken == null) {
      return null;
    }

    return <String, String>{
      'client': client,
      'uid': uid,
      'access-token': acessToken
    };*/
  }
}