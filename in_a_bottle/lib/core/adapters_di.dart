import 'package:http/http.dart' as http;
import 'package:in_a_bottle/adapters/injection/base_injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/adapters/network/http_client.dart';
import 'package:in_a_bottle/adapters/route/navigation_service.dart';

class AdaptersDi extends InjectorModule {
  @override
  void initialise(BaseInjector injector) {
    //injector.register((injector) => "http://04c02d1cabed.ngrok.io", key: api);
    injector.register<http.Client, ClientHttp>((injector) => ClientHttp());

    injector.register<NavigationService, NavigationServiceImp>(
        (injector) => NavigationServiceImp());
  }
}
