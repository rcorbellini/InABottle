import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/local_message/talk/talk_repository.dart';

class HomeDi {
  Injector initialise(Injector injector) {
    injector.map<TalkRepository>((i) => TalkDataRepository());
    injector.map<HomeBloc>((i) => HomeBloc(talkRepository: i.get()));

    return injector;
  }
}
