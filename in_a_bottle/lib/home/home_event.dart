import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';

abstract class HomeEvent {}

class LoadTalks implements HomeEvent {
  LoadTalks();
}

class LocationChange implements HomeEvent {
  final Point location;
  LocationChange(this.location);
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

class SelectReaction extends HomeEvent {
  final TypeReaction reaction;
  final DirectMessage message;

  SelectReaction(this.reaction, this.message);
}
