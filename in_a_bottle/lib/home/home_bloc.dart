import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/local_message/hub/chat_repository.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/local_message/talk/talk_dto.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Disposable {
  static const String route = '/home';

  final TalkRepository talkRepository;
  final ChatRepository chatRepository;
  final MessageRepository messageRepository;
  final SessionRepository sessionRepository;
  final Navigator navigator;

  HomeBloc({
    @required this.talkRepository,
    @required this.navigator,
    @required this.chatRepository,
    @required this.messageRepository,
    @required this.sessionRepository,
  }) {
    listenOn<HomeEvent>(_handleEvents);
    dispatchOn<HomeEvent>(LoadTalks());
    dispatchOn<HomeEvent>(LoadFeed());

    sessionRepository.load().then(dispatchOn);
  }

  Future<void> _handleEvents(HomeEvent homeEvent) async {
    if (homeEvent is LoadTalks) {
      await loadAllTalks();
    } else if (homeEvent is LoadFeed) {
      await loadAllFeed();
    } else if (homeEvent is GoToRoute) {
      await navigator.navigateTo<void>(homeEvent.route,
          params: homeEvent.params);
      await loadAllTalks();
      await loadAllFeed();
    }
  }

  Future<void> loadAllTalks() async {
    dispatchOn<List<Talk>>(await talkRepository.loadAll());
  }

  Future<void> loadAllFeed() async {
    final List<HomeFeed> feedList = [];
    final List<HomeFeed> t = await chatRepository.loadAll();
    final List<HomeFeed> t2 = await messageRepository.loadAll();
    feedList.addAll(t);
    feedList.addAll(t2);
    dispatchOn<List<HomeFeed>>(feedList);
  }
}
