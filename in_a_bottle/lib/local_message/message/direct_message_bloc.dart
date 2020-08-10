import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/local_message/message/direct_message_dto.dart';
import 'package:in_a_bottle/local_message/message/direct_message_event.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:in_a_bottle/user/user_dto.dart';
import 'package:meta/meta.dart';

class DirectMessageBloc extends BaseBloc<DirectMessageEvent> {
  static const String route = "/addDirectMessage";
  final MessageDataRepository messageDataRepository;
  final SessionRepository sessionRepository;

  DirectMessageBloc(
      {@required this.messageDataRepository,
      @required this.sessionRepository}) {
    sessionRepository
        .load()
        .then((session) => dispatchOn<User>(session.user, key: "user"));
  }

  @override
  void onEvent(DirectMessageEvent event) {
    if (event is DirectMessageSave) {
      _save();
    }
  }

  void _save() {
    final map = valuesToMap();
    messageDataRepository.save(DirectMessage.fromMap(map));
  }
}

enum KeysForm {
  text,
  title,
  user,
  local,
}
