import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_repository.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_repository.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Disposable {
  static const String route = '/home';

  final TalkRepository talkRepository;
  final HubMessageRepository chatRepository;
  final DirectMessageRepository messageRepository;
  final TreasureHuntRepository treasureHuntRepository;
  final SessionRepository sessionRepository;
  final LocationRepository locationRepository;
  final Navigator navigator;

  HomeBloc(
      {@required this.talkRepository,
      @required this.navigator,
      @required this.chatRepository,
      @required this.messageRepository,
      @required this.sessionRepository,
      @required this.locationRepository,
      @required this.treasureHuntRepository}) {
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
      loadHomeByPosition(await locationRepository.loadCurrentPosition());
    } else if (homeEvent is LocationChange) {
      loadHomeByPosition(homeEvent.location);
    }
  }

  void loadHomeByPosition(Point position) {
    loadTalksByLocation(position);
    loadFeedByLocation(position);
    loadTreasureHuntByLocation(position);
  }

  Future<void> loadTreasureHuntByLocation(Point location) async {
    dispatchOn<List<TreasureHunt>>(
        await treasureHuntRepository.loadByLocation(location));
  }

  Future<void> loadTalksByLocation(Point location) async {
    dispatchOn<List<Talk>>(await talkRepository.loadByLocation(location));
  }

  List<HomeFeed> lastDirectMessages = [];
  List<HomeFeed> lastHubs = [];

  Future<void> loadFeedByLocation(Point location) async {
    //combineLatest
    messageRepository.loadByLocation(location).listen((event) {
      lastDirectMessages = event;
      _dispatchLastFeedLoaded();
    });
    messageRepository.loadByLocation(location).listen((event) {
      lastHubs = event;
      _dispatchLastFeedLoaded();
    });
  }

  void _dispatchLastFeedLoaded() {
    final allFeed = [lastDirectMessages, lastHubs];
    dispatchOn<List<HomeFeed>>(allFeed.expand((e) => e).toList());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
