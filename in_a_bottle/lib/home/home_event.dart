import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';

abstract class HomeEvent {}

class LoadTalks implements HomeEvent {
  LoadTalks();
}

class LoadFeed implements HomeEvent {
  LoadFeed();
}

class LoadTimeLine {}

class GoToRoute extends HomeEvent {
  final String route;
  final Map<String, dynamic> params;

  GoToRoute(this.route, {this.params});
}
