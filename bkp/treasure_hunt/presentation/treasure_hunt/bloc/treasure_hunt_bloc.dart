import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/location/geo_location.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as nav;
import 'package:in_a_bottle/adapters/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/treasure_hunt.dart';
import 'package:in_a_bottle/features/treasure_hunt/data/repositories/treasure_hunt_repository_imp.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/message_treasure_bloc.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TreasureHuntBloc extends CrudBloc<TreasureHuntForm, TreasureHunt> {
  final TreasureHuntRepository treasureHuntRepository;
  final LocationRepository locationRepository;
  final SessionRepository sessionRepository;
  final nav.Navigator navigator;

  static const String route = "/addTreasureHunt";

  TreasureHuntBloc(
      {@required this.treasureHuntRepository,
      @required this.navigator,
      @required this.sessionRepository,
      @required this.locationRepository})
      : assert(treasureHuntRepository != null),
        assert(navigator != null),
        assert(locationRepository != null);

  @override
  Future<void> onEvent(TreasureHuntForm event) async {
    super.onEvent(event);
    if (event == TreasureHuntForm.actionAddMessage) {
      final dm =
          await navigator.navigateTo<DirectMessage>(MessageTreasureBloc.route);
      addMessage(dm);
    }
  }

  void addMessage(DirectMessage directMessage) {
    if (directMessage == null) {
      return;
    }

    final map = valuesToMap<TreasureHuntForm>();
    final List<DirectMessage> messages = map[TreasureHuntForm.messages] ?? [];

    messages.add(directMessage);

    dispatchOn<List<DirectMessage>>(messages, key: TreasureHuntForm.messages);
  }

  @override
  Future<TreasureHunt> buildEntity() async {
    final map = valuesToMap<TreasureHuntForm>();
    final isPrivateDM = map[TreasureHuntForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[TreasureHuntForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();
    final dateRange = map[TreasureHuntForm.dateRangeDuration] as DateTimeRange;
    final startDate = dateRange?.start;
    final endDate = dateRange?.end;
    final session = await sessionRepository.load();
    final messages = map[TreasureHuntForm.messages];

    return TreasureHunt(
      title: map[TreasureHuntForm.textDescription] as String,
      description: map[TreasureHuntForm.textDescription] as String,
      status: statusPendente,
      createdBy: session.user,
      createdAt: DateTime.now(),
      startDate: startDate,
      endDate: endDate,
      messages: messages,
      createdOn: Local(
          isPrivateDM: isPrivateDM,
          reach: Reach(value: map[TreasureHuntForm.sliderReach] as double),
          password: password,
          point: currentPosition),
    );
  }

  @override
  Future<bool> validate(TreasureHunt entity) async {
    final errors = <TreasureHuntError>[];
    if ((entity.title?.trim() ?? "").isEmpty) {
      errors.add(TreasureHuntError.emptyTitle);
    }

    if ((entity.description?.trim() ?? "").isEmpty) {
      errors.add(TreasureHuntError.emptyDescription);
    }

    if ((entity.createdOn?.isPrivateDM ?? false) &&
        (entity.createdOn?.password?.trim() ?? "").isEmpty) {
      errors.add(TreasureHuntError.emptyPassword);
    }

    dispatchOn<List<TreasureHuntError>>(errors);
    return errors.isEmpty;
  }

  @override
  Future<void> save(TreasureHunt entity) async {
    await treasureHuntRepository.save(entity);
    navigator.pop();
  }
}

enum TreasureHuntForm {
  textTitle,
  textDescription,
  actionSave,
  actionAddMessage,
  dateRangeDuration,
  tags,
  boolPrivate,
  textPassword,
  sliderReach,
  messages,
}

enum TreasureHuntError {
  emptyPassword,
  emptyTitle,
  emptyDescription,
}
