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
import 'package:in_a_bottle/location/location_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

class DirectMessageBloc extends BaseBloc<DirectMessageEvent>
    with CampoObrigatorioValidator, NameValidator {
  static const String route = "/addDirectMessage";
  final MessageRepository messageDataRepository;
  final SessionRepository sessionRepository;
  final LocationRepository locationRepository;
  final Navigator navigator;

  DirectMessageBloc(
      {@required this.messageDataRepository,
      @required this.sessionRepository,
      @required this.navigator,
      @required this.locationRepository}) {
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

  Future<void> _save() async {
    final map = valuesToMap();
    final dm = DirectMessage.fromMap(map);
    final owner = (await sessionRepository.load()).user;
    final position = await locationRepository.loadCurrentPosition();
    navigator.pop();
  }
}

enum KeysForm {
  text,
  title,
  user,
  local,
}
