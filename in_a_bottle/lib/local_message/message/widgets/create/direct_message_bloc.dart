import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/_shared/transformers/campo_obrigatorio_validator.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

class DirectMessageBloc extends CrudBloc<DirectMessageForm, Message>
    with CampoObrigatorioValidator {
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
    addTransformOn(validateObrigatorio, key: DirectMessageForm.textContent);
    addTransformOn(validateObrigatorio, key: DirectMessageForm.textTitle);
  }

  @override
  Future<Message> buildEntity() async {
    final map = valuesToMap<DirectMessageForm>();
    final session = await sessionRepository.load();
    final isPrivateDM = map[DirectMessageForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[DirectMessageForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();

    return Message(
        text: map[DirectMessageForm.textContent] as String,
        title: map[DirectMessageForm.textTitle] as String,
        owner: session.user,
        local: Local(
            isPrivateDM: isPrivateDM,
            reach: Reach(value: map[DirectMessageForm.sliderReach] as double),
            password: password,
            point: currentPosition));
  }

  @override
  Future<bool> validate(Message entity) async {
    final errors = <DirectMessageError>[];
    if ((entity.title?.trim() ?? "").isEmpty) {
      errors.add(DirectMessageError.emptyTitle);
    }

    if ((entity.text?.trim() ?? "").isEmpty) {
      errors.add(DirectMessageError.emptyContent);
    }

    if ((entity.local?.isPrivateDM ?? false) &&
        (entity.local?.password?.trim() ?? "").isEmpty) {
      errors.add(DirectMessageError.emptyPassword);
    }

    dispatchOn<List<DirectMessageError>>(errors);
    return errors.isEmpty;
  }

  @override
  Future<void> save(Message entity) async {
    await messageDataRepository.save(entity);
    navigator.pop();
  }
}

enum DirectMessageForm {
  textContent,
  textTitle,
  textPassword,
  boolPrivate,
  sliderReach,
  actionSave
}

enum DirectMessageError {
  emptyTitle,
  emptyContent,
  emptyPassword,
}
