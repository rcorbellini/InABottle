import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/_shared/transformers/campo_obrigatorio_validator.dart';
import 'package:in_a_bottle/_shared/transformers/name_validator.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/direct_message_dto.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

class DirectMessageBloc extends CrudBloc<KeysForm, DirectMessage>
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
    addTransformOn(validateObrigatorio, key: KeysForm.text);
    addTransformOn(validateObrigatorio, key: KeysForm.title);
    addTransformOn(validateName, key: KeysForm.title);
  }

  @override
  Future<DirectMessage> buildEntity() async {
    final map = valuesToMap<KeysForm>();
    final session = await sessionRepository.load();
    final isPrivateDM = map[KeysForm.private] as bool ?? true;
    final password = isPrivateDM ? map[KeysForm.password]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();

    return DirectMessage(
        text: map[KeysForm.text] as String,
        title: map[KeysForm.title] as String,
        owner: session.user,
        local: Local(
            reach: Reach(value: map[KeysForm.reach] as double),
            password: password,
            point: currentPosition));
  }

  @override
  Future<void> save(DirectMessage entity) async {
    await messageDataRepository.save(entity);
    navigator.pop();
  }
}

enum KeysForm { text, title, password, private, reach, actionSave }
