import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as nav;
import 'package:in_a_bottle/local_message/talk/talk_dto.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TalkBloc extends CrudBloc<TalkForm, Talk> {
  final TalkRepository talkRepository;
  final nav.Navigator navigator;

  static const String route = "/addTalk";

  TalkBloc({@required this.talkRepository, @required this.navigator})
      : assert(talkRepository != null),
        assert(navigator != null);

  @override
  Future<Talk> buildEntity() async {
    final map = valuesToMap<TalkForm>();
    final dateRange = map[TalkForm.dateRangeDuration] as DateTimeRange;
    final startDate = dateRange?.start;
    final endDate = dateRange?.end;

    return Talk(
        title: map[TalkForm.textDescription] as String,
        descrition: map[TalkForm.textDescription] as String,
        startDate: startDate,
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

    dispatchOn<List<TalkError>>(errors, key: TalkForm.errorMessages);
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
  boolPrivate,
  textPassword,
  sliderReach,
  errorMessages
}

enum TalkError {
  title,
  emptyPassword,
  emptyTitle,
  emptyDescription,
  emptyDateRange,
}
