import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_repository.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/tag/tag_repository.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class CreateHubMessageBloc extends CrudBloc<ChatForm, HubMessage> {
  static const route = "/addChat";

  final HubMessageRepository chatRepository;
  final Navigator navigator;
  final SessionRepository sessionRepository;
  final LocationRepository locationRepository;
  final TagRepository tagRepository;

  CreateHubMessageBloc({
    @required this.chatRepository,
    @required this.navigator,
    @required this.sessionRepository,
    @required this.locationRepository,
    @required this.tagRepository,
  })  : assert(chatRepository != null),
        assert(navigator != null),
        assert(sessionRepository != null),
        assert(locationRepository != null) {
    tagRepository
        .loadAll()
        .then((value) => dispatchOn(value, key: ChatForm.tags));
  }

  @override
  Future<HubMessage> buildEntity() async {
    final map = valuesToMap<ChatForm>();
    final session = await sessionRepository.load();
    final isPrivateDM = map[ChatForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[ChatForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();

    return HubMessage(
        admin: [session.user],
        status: statusPendente,
        createdBy: session.user,
        createdAt: DateTime.now(),
        createdOn: Local(
            reach: Reach(value: map[ChatForm.sliderReach] as double),
            password: password,
            isPrivateDM: isPrivateDM,
            point: currentPosition),
        title: map[ChatForm.textTitle] as String);
  }

  @override
  Future<void> save(HubMessage entity) async {
    await chatRepository.save(entity);
    navigator.pop();
  }

  @override
  Future<bool> validate(HubMessage entity) async {
    final errors = <ChatError>[];
    if ((entity.title?.trim() ?? "").isEmpty) {
      errors.add(ChatError.emptyTitle);
    }

    if ((entity.createdOn?.isPrivateDM ?? false) &&
        (entity.createdOn?.password?.trim() ?? "").isEmpty) {
      errors.add(ChatError.emptyPassword);
    }

    dispatchOn<List<ChatError>>(errors);
    return errors.isEmpty;
  }
}

enum ChatForm {
  textTitle,
  boolPrivate,
  tags,
  textPassword,
  sliderReach,
  actionSave,
}

enum ChatError {
  emptyPassword,
  emptyTitle,
}
