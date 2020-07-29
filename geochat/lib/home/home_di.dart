import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/local_message/talk/talk_repository.dart';

class HomeDi {
  Injector initialise(Injector injector) {
    injector.map<TalkRepository>((i) => TalkDataRepository());

    injector.map<HomeBloc>((i) => HomeBloc(talkRepository: i.get()));

    /**     

    injector.map<Logger>((i) => Logger(), isSingleton: true);
    injector.map<String>((i) => "https://api.com/", key: "apiUrl");
    injector.map<SomeService>(
        (i) => SomeService(i.get<Logger>(), i.get<String>(key: "apiUrl")));

    injector.map<SomeType>((injector) => SomeType("0"));
    injector.map<SomeType>((injector) => SomeType("1"), key: "One");
    injector.map<SomeType>((injector) => SomeType("2"), key: "Two");

    injector.mapWithParams<SomeOtherType>((i, p) => SomeOtherType(p["id"]));

     */

    return injector;
  }
}
