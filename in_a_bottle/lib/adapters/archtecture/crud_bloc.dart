import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_a_bottle/adapters/archtecture/base_bloc.dart';
import 'package:in_a_bottle/adapters/utils.dart';

abstract class CrudBloc<EVENT, ENTITY> extends BaseBloc<EVENT> {
  @override
  @mustCallSuper
  Future<void> onEvent(EVENT event) async {
    if (isEnum(event)) {
      final descr = enumToString(event);
      final savedesc = enumToString(KeyActionform.actionSave);
      if (descr == savedesc) {
        final entity = await buildEntity();
        if (await validate(entity)) {
          return await save(entity);
        }
      } else if (descr == enumToString(KeyActionform.actionDelete)) {
        return delete();
      } else if (descr == enumToString(KeyActionform.actionLoadAll)) {
        return loadAll();
      }     
    }
  }

  FutureOr<void> save(ENTITY entity) {
    throw UnimplementedError("Not implemented yet");
  }

  FutureOr<void> loadAll() {
    throw UnimplementedError("Not implemented yet");
  }

  FutureOr<void> delete() {
    throw UnimplementedError("Not implemented yet");
  }

  Future<ENTITY> buildEntity();

  FutureOr<bool> validate(ENTITY entity) {
    return true;
  }
}

enum KeyActionform { actionSave, actionDelete, actionLoadAll }
