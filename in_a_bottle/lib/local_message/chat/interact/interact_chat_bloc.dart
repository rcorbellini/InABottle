import 'package:fancy_stream/fancy_stream.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/local_message/chat/chat_repository.dart';
import 'package:in_a_bottle/local_message/chat/interact/interact_event.dart';

class InteractChatBloc extends BaseBloc<InteractEvent> {
  static const String route = '/interactChat';
  final ChatRepository chatRepository;

  InteractChatBloc({
    @required this.chatRepository,
  });

  @override
  Future<void> onEvent(InteractEvent event) {
    if (event is InteractLoadChat) {
      _loadBySelector(event.selector);
    }
  }

  Future<void> _loadBySelector(String selector) async{
      final chat = await chatRepository.loadByKey(selector);
      dispatchOn(chat);
  }
}
