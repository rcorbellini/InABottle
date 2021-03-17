import 'package:in_a_bottle/adapters/injection/base_injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/adapters/network/http_client.dart';

class AdaptersDi extends InjectorModule {
  @override
  void initialise(BaseInjector injector) {
    //injector.register((injector) => "http://04c02d1cabed.ngrok.io", key: api);
    injector
        .register<Http2Client, Http2ClientImp>((injector) => Http2ClientImp());
  }
}
