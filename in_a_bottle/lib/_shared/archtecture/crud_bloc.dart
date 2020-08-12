import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/utils.dart';

abstract class CrudBloc<T, E> extends BaseBloc<T> {
  @override
  @mustCallSuper
  Future<void> onEvent(T event) async{
    if (isEnum(event)) {
      final descr = enumToString(event);
      final savedesc = enumToString(KeyActionform.actionSave);
      if (descr == savedesc) {
        return await save(await buildEntity());
      } else if (descr == enumToString(KeyActionform.actionDelete)) {
        return delete();
      } else if (descr == enumToString(KeyActionform.actionLoadAll)) {
        return loadAll();
      }
    }

    throw UnimplementedError("Only enum KeyActionform actions alowed");
  }

  FutureOr<void> save(E entity){
    throw UnimplementedError("Not implemented yet");
  }

  FutureOr<void> loadAll(){
    throw UnimplementedError("Not implemented yet");
  }

  FutureOr<void> delete(){
    throw UnimplementedError("Not implemented yet");
  }

  Future<E> buildEntity(){
    throw UnimplementedError("Not implemented yet");
  }
  
}

enum KeyActionform { actionSave, actionDelete, actionLoadAll }
