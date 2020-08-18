import 'package:fancy_stream/fancy_stream.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/local_message/chat/chat_repository.dart';
import 'package:in_a_bottle/local_message/chat/interact/interact_chat_event.dart';

class InteractChatBloc extends BaseBloc<InteractChatEvent> {
  static const String route = '/interactChat';
  final ChatRepository chatRepository;

  InteractChatBloc({
    @required this.chatRepository,
  });

  @override
  Future<void> onEvent(InteractChatEvent event) async {
    if (event is LoadChat) {
      await _loadBySelector(event.selector);
    }
  }

  Future<void> _loadBySelector(String selector) async{
      final entity = await chatRepository.loadByKey(selector);
      dispatchOn(entity);
  }
}
