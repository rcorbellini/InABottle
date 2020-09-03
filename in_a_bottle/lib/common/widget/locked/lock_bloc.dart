import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/local/local.dart';

class LockBloc extends CrudBloc<LockForm, String> {


  @override
  Future<String> buildEntity() async {
    final map = valuesToMap<LockForm>();
    return map[LockForm.textPassword] as String;
  }

  @override
  bool validate(String password) {
    final map = valuesToMap<LockForm>();
    final local = map[LockForm.local] as Local;

    final List<LockErro> errors = [];

    if (password?.isEmpty ?? true) {
      errors.add(LockErro.emptyPassword);
    } else if (password != local.password) {
      errors.add(LockErro.wrongPassword);
    }

    dispatchOn<List<LockErro>>(errors);
    return errors.isEmpty;
  }

  @override
  void save(String password) {
    final map = valuesToMap<LockForm>();
    final local = map[LockForm.local] as Local;

    dispatchOn(local.copyWith(isLocked: false), key: LockForm.local);

  }

}

enum LockForm { textPassword, actionSave, local}

enum LockErro { emptyPassword, wrongPassword, internalErro }
