import 'package:in_a_bottle/_shared/archtecture/crud_bloc.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';
import 'package:in_a_bottle/local_message/hub/chat_repository.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class CreateChatBloc extends CrudBloc<ChatForm, Chat> {
  static const route = "/addChat";

  final ChatRepository chatRepository;
  final Navigator navigator;
  final SessionRepository sessionRepository;
  final LocationRepository locationRepository;

  CreateChatBloc(
      {@required this.chatRepository,
      @required this.navigator,
      @required this.sessionRepository,
      @required this.locationRepository})
      : assert(chatRepository != null),
        assert(navigator != null),
        assert(sessionRepository != null),
        assert(locationRepository != null);

  @override
  Future<Chat> buildEntity() async {
    final map = valuesToMap<ChatForm>();
    final session = await sessionRepository.load();
    final isPrivateDM = map[ChatForm.boolPrivate] as bool ?? false;
    final password =
        isPrivateDM ? map[ChatForm.textPassword]?.toString() : null;
    final currentPosition = await locationRepository.loadCurrentPosition();

    return Chat(
        admin: [session.user],
        createdBy: session.user,
        local: Local(
            reach: Reach(value: map[ChatForm.sliderReach] as double),
            password: password,
            isPrivateDM: isPrivateDM,
            point: currentPosition),
        title: map[ChatForm.textTitle] as String);
  }

  @override
  Future<void> save(Chat entity) async {
    await chatRepository.save(entity);
    navigator.pop();
  }

  @override
  Future<bool> validate(Chat entity) async {
    final errors = <ChatError>[];
    if ((entity.title?.trim() ?? "").isEmpty) {
      errors.add(ChatError.emptyTitle);
    }

    if ((entity.local?.isPrivateDM ?? false) &&
        (entity.local?.password?.trim() ?? "").isEmpty) {
      errors.add(ChatError.emptyPassword);
    }

    dispatchOn<List<ChatError>>(errors);
    return errors.isEmpty;
  }
}

enum ChatForm {
  textTitle,
  boolPrivate,
  textPassword,
  sliderReach,
  actionSave,
}

enum ChatError {
  emptyPassword,
  emptyTitle,
}
