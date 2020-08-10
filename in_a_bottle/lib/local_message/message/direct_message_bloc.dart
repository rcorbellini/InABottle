import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/_shared/transformers/campo_obrigatorio_validator.dart';
import 'package:in_a_bottle/_shared/transformers/name_validator.dart';
import 'package:in_a_bottle/_shared/utils.dart';
import 'package:in_a_bottle/local_message/message/direct_message_dto.dart';
import 'package:in_a_bottle/local_message/message/direct_message_event.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:in_a_bottle/user/user_dto.dart';
import 'package:meta/meta.dart';

class DirectMessageBloc extends BaseBloc<DirectMessageEvent>
    with CampoObrigatorioValidator , NameValidator{
  static const String route = "/addDirectMessage";
  final MessageRepository messageDataRepository;
  final SessionRepository sessionRepository;
  final Navigator navigator;

  DirectMessageBloc(
      {@required this.messageDataRepository,
      @required this.sessionRepository,
      @required this.navigator}) {
    sessionRepository
        .load()
        .then((session) => dispatchOn<User>(session.user, key: "user"));

    addTransformOn(validateObrigatorio, enumToString(KeysForm.text));
    addTransformOn(validateObrigatorio, enumToString(KeysForm.title));
    addTransformOn(validateName, enumToString(KeysForm.title));
  }

  @override
  void onEvent(DirectMessageEvent event) {
    if (event is DirectMessageSave) {
      _save();
    }
  }

  Future <void> _save() async {
    final map = valuesToMap();
    await messageDataRepository.save(DirectMessage.fromMap(map));
    navigator.pop();
  }
}

enum KeysForm {
  text,
  title,
  user,
  local,
}
