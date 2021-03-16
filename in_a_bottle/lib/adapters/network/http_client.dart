import 'dart:convert';
import 'dart:io';

import 'package:http2/http2.dart';

class RequestHttp2 {
  final Uri uri;
  final String method;
  final Map<String, String> headers;

  RequestHttp2(
      {required this.uri, required this.method, required this.headers});
}

abstract class Http2Client {
  Stream<String> stream(RequestHttp2 requestHttp2);
}

class Http2ClientImp implements Http2Client {
  @override
  Stream<String> stream(RequestHttp2 requestHttp2) async* {
    final uri = requestHttp2.uri;

    var transport = new ClientTransportConnection.viaSocket(
      await SecureSocket.connect(
        uri.host,
        uri.port,
        supportedProtocols: ['h2'],
      ),
    );

    var stream = transport.makeRequest(
      [
        Header.ascii(':method', 'GET'),
        Header.ascii(':path', uri.path),
        Header.ascii(':scheme', uri.scheme),
        Header.ascii(':authority', uri.host),
      ],
      endStream: true,
    );

    await for (var message in stream.incomingMessages) {
      if (message is HeadersStreamMessage) {
        for (var header in message.headers) {
          var name = utf8.decode(header.name);
          var value = utf8.decode(header.value);
          print('Header: $name: $value');
        }
      } else if (message is DataStreamMessage) {
        print(message.bytes);
        // Use [message.bytes] (but respect 'content-encoding' header)
      }
    }
    await transport.finish();
  }
}
