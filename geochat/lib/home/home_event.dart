import 'package:geochat/local_message/local/local_dto.dart';

abstract class HomeEvent {}

class AddLocal extends HomeEvent {
  final TypeLocal type;

  AddLocal(this.type);
}

class LoadTalks implements HomeEvent {
  LoadTalks();
}

class LoadTimeLine {}

class GoToRoute extends HomeEvent {
  final String route;

  GoToRoute(this.route);
}
