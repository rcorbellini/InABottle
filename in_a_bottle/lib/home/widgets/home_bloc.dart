import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/local_message/hub/chat_repository.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/local_message/talk/talk_model.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Disposable {
  static const String route = '/home';

  final TalkRepository talkRepository;
  final ChatRepository chatRepository;
  final MessageRepository messageRepository;
  final SessionRepository sessionRepository;
  final LocationRepository locationRepository;
  final Navigator navigator;

  HomeBloc({
    @required this.talkRepository,
    @required this.navigator,
    @required this.chatRepository,
    @required this.messageRepository,
    @required this.sessionRepository,
    @required this.locationRepository,
  }) {
    //TODO usar BaseBloc
    listenOn<HomeEvent>(_handleEvents);
    sessionRepository.load().then(dispatchOn);
    locationRepository.loadCurrentPosition().then(loadHomeByPosition);
  }

  Future<void> _handleEvents(HomeEvent homeEvent) async {
    if (homeEvent is LoadTalks) {
      await loadTalksByLocation(null);
    } else if (homeEvent is LoadFeed) {
      await loadFeedByLocation(null);
    } else if (homeEvent is GoToRoute) {
      await navigator.navigateTo<void>(homeEvent.route,
          params: homeEvent.params);

      loadHomeByPosition(Point(latitude: 0, longitude: 0));
    } else if (homeEvent is LocationChange) {
      loadHomeByPosition(homeEvent.location);
    }
  }

  void loadHomeByPosition(Point position) {
    loadTalksByLocation(position);
    loadFeedByLocation(position);
  }

  Future<void> loadTalksByLocation(Point location) async {
    dispatchOn<List<Talk>>(await talkRepository.loadAllByLocation(location));
  }

  Future<void> loadFeedByLocation(Point location) async {    
    final List<HomeFeed> feedList = [];
    final List<HomeFeed> t = [];
    final List<HomeFeed> t2 =
        await messageRepository.loadAllByLocation(location);
    feedList.addAll(t);
    feedList.addAll(t2);
    dispatchOn<List<HomeFeed>>(feedList);
  }
}
