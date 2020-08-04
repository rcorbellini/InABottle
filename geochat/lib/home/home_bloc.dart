import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:geochat/_shared/route/navigator.dart';
import 'package:geochat/home/home_feed.dart';
import 'package:geochat/home/home_event.dart';
import 'package:geochat/local_message/chat/chat_repository.dart';
import 'package:geochat/local_message/message/message_repository.dart';
import 'package:geochat/local_message/talk/talk_dto.dart';
import 'package:geochat/local_message/talk/talk_repository.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Disposable {
  static const String route = '/home';

  final TalkRepository talkRepository;
  final ChatRepository chatRepository;
  final MessageRepository messageRepository;
  final Navigator navigator;

  HomeBloc({
    @required this.talkRepository,
    @required this.navigator,
    @required this.chatRepository,
    @required this.messageRepository,
  }) {
    listenOn<HomeEvent>(_handleEvents);
    dispatchOn<HomeEvent>(LoadTalks());
    dispatchOn<HomeEvent>(LoadFeed());
  }

  void _handleEvents(HomeEvent homeEvent) {
    if (homeEvent is LoadTalks) {
      loadAllTalks();
    } else if (homeEvent is LoadFeed) {
      loadAllFeed();
    } else if (homeEvent is GoToRoute) {
      navigator.navigateTo<void>(homeEvent.route);
    }
  }

  Future<void> loadAllTalks() async {
    dispatchOn<List<Talk>>(await talkRepository.loadAll());
  }

  Future<void> loadAllFeed() async {
    dispatchOn<List<HomeFeed>>(await messageRepository.loadAll());
  }
}
