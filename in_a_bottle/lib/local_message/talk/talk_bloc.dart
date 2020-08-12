import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as nav;
import 'package:in_a_bottle/local_message/talk/talk_dto.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TalkBloc extends CrudBloc<TalkKeysForm, Talk> {
  final TalkRepository talkRepository;
  final nav.Navigator navigator;

  static const String route = "/addTalk";

  TalkBloc({@required this.talkRepository, @required this.navigator})
      : assert(talkRepository != null),
        assert(navigator != null);

  @override
  Future<Talk> buildEntity() async {
    final map = valuesToMap<TalkKeysForm>();
    final dateRange = map[TalkKeysForm.dateRange] as DateTimeRange;
    final startDate = dateRange.start;
    final endDate = dateRange.end;

    return Talk(
        title: map[TalkKeysForm.title] as String,
        descrition: map[TalkKeysForm.description] as String,
        startDate: startDate,
        endDate: endDate);
  }

  @override
  Future<void> save(Talk entity) async {
    await talkRepository.save(entity);
    navigator.pop();
  }
}

enum TalkKeysForm { title, description, dateRange, actionSave }
