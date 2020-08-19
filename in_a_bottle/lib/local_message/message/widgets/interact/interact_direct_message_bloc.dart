import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_event.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';

class InteractDirectMessageBloc extends BaseBloc<InteractDirectMessageEvent> {
  static const String route = '/interactDirectMessage';
  final MessageRepository messageRepository;

  InteractDirectMessageBloc({
    @required this.messageRepository,
  });

  @override
  Future<void> onEvent(InteractDirectMessageEvent event) async {
    if (event is LoadDirectMessage) {
      await _loadBySelector(event.selector);
    }
  }

  Future<void> _loadBySelector(String selector) async {
    final entity = await messageRepository.loadByKey(selector);
    dispatchOn(entity);
  }
}
