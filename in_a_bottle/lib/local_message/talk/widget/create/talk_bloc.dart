import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as nav;
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TalkBloc extends CrudBloc<TalkForm, Talk> {
  final TalkRepository talkRepository;
  final LocationRepository locationRepository;
  final nav.Navigator navigator;

  static const String route = "/addTalk";

  TalkBloc(
      {@required this.talkRepository,
      @required this.navigator,
      @required this.locationRepository})
      : assert(talkRepository != null),
        assert(navigator != null),
        assert(locationRepository != null);

  @override
  Future<Talk> buildEntity() async {
    final map = valuesToMap<TalkForm>();
    final dateRange = map[TalkForm.dateRangeDuration] as DateTimeRange;
    final isPrivateDM = map[TalkForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[TalkForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();
    final startDate = dateRange?.start;
    final endDate = dateRange?.end;

    return Talk(
        title: map[TalkForm.textDescription] as String,
        descrition: map[TalkForm.textDescription] as String,
        startDate: startDate,
        local: Local(
            isPrivateDM: isPrivateDM,
            reach: Reach(value: map[TalkForm.sliderReach] as double),
            password: password,
            point: currentPosition),
        endDate: endDate);
  }

  @override
  Future<bool> validate(Talk entity) async {
    final errors = <TalkError>[];
    if ((entity.title?.trim() ?? "").isEmpty) {
      errors.add(TalkError.emptyTitle);
    }

    if ((entity.descrition?.trim() ?? "").isEmpty) {
      errors.add(TalkError.emptyDescription);
    }

    if ((entity.local?.isPrivateDM ?? false) &&
        (entity.local?.password?.trim() ?? "").isEmpty) {
      errors.add(TalkError.emptyPassword);
    }

    if (entity.startDate == null || entity.endDate == null) {
      errors.add(TalkError.emptyDateRange);
    }

    dispatchOn<List<TalkError>>(errors);
    return errors.isEmpty;
  }

  @override
  Future<void> save(Talk entity) async {
    await talkRepository.save(entity);
    navigator.pop();
  }
}

enum TalkForm {
  textTitle,
  textDescription,
  dateRangeDuration,
  actionSave,
  tags,
  boolPrivate,
  textPassword,
  sliderReach
}

enum TalkError {
  emptyPassword,
  emptyTitle,
  emptyDescription,
  emptyDateRange,
}
