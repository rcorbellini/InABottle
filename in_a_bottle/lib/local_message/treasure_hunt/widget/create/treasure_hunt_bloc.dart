import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as nav;
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TreasureHuntBloc extends CrudBloc<TreasureHuntForm, TreasureHunt> {
  final TreasureHuntRepository treasureHuntRepository;
  final LocationRepository locationRepository;
  final nav.Navigator navigator;

  static const String route = "/addTreasureHunt";

  TreasureHuntBloc(
      {@required this.treasureHuntRepository,
      @required this.navigator,
      @required this.locationRepository})
      : assert(treasureHuntRepository != null),
        assert(navigator != null),
        assert(locationRepository != null);

  @override
  Future<TreasureHunt> buildEntity() async {
    final map = valuesToMap<TreasureHuntForm>();
    final isPrivateDM = map[TreasureHuntForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[TreasureHuntForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();

    return TreasureHunt(
      title: map[TreasureHuntForm.textDescription] as String,
      description: map[TreasureHuntForm.textDescription] as String,
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
  tags,
  boolPrivate,
  textPassword,
  sliderReach
}

enum TreasureHuntError {
  emptyPassword,
  emptyTitle,
  emptyDescription,
}
