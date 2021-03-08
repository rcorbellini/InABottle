import 'dart:async';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/_shared/transformers/campo_obrigatorio_validator.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_repository.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class DirectMessageBloc extends CrudBloc<DirectMessageForm, DirectMessage>
    with CampoObrigatorioValidator {
  static const String route = "/addDirectMessage";

  final DirectMessageRepository messageDataRepository;
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
  Future<DirectMessage> buildEntity() async {
    final map = valuesToMap<DirectMessageForm>();
    final session = await sessionRepository.load();
    final isPrivateDM = map[DirectMessageForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[DirectMessageForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();

    return DirectMessage(
        message: Message(
          text: map[DirectMessageForm.textContent] as String,
          title: map[DirectMessageForm.textTitle] as String,
          createdAt: DateTime.now(),
          createdBy: session.user,
        ),
        createdAt: DateTime.now(),
        createdBy: session.user,
        status: statusPendente,
        createdOn: Local(
            isPrivateDM: isPrivateDM,
            reach: Reach(value: map[DirectMessageForm.sliderReach] as double),
            password: password,
            point: currentPosition));
  }

  @override
  Future<bool> validate(DirectMessage entity) async {
    final errors = <DirectMessageError>[];
    if ((entity.message.title?.trim() ?? "").isEmpty) {
      errors.add(DirectMessageError.emptyTitle);
    }

    if ((entity.message.text?.trim() ?? "").isEmpty) {
      errors.add(DirectMessageError.emptyContent);
    }

    if ((entity.createdOn?.isPrivateDM ?? false) &&
        (entity.createdOn?.password?.trim() ?? "").isEmpty) {
      errors.add(DirectMessageError.emptyPassword);
    }

    dispatchOn<List<DirectMessageError>>(errors);
    return errors.isEmpty;
  }

  @override
  Future<void> save(DirectMessage entity) async {
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
  tags,
  actionSave
}

enum DirectMessageError {
  emptyTitle,
  emptyContent,
  emptyPassword,
}
