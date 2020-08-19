import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_event.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';

class InteractTalkBloc extends BaseBloc<InteractTalkEvent> {
  static const String route = '/interactTalk';
  final TalkRepository talkRepository;

  InteractTalkBloc({
    @required this.talkRepository,
  });

  @override
  Future<void> onEvent(InteractTalkEvent event) async {
    if (event is LoadTalk) {
      await _loadBySelector(event.selector);
    }
  }

  Future<void> _loadBySelector(String selector) async {
    final entity = await talkRepository.loadByKey(selector);
    dispatchOn(entity);
  }
}
