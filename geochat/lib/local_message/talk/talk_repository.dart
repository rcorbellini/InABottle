import 'package:geochat/local_message/talk/talk_dto.dart';

abstract class TalkRepository {
  Future<List<Talk>> loadAll();
}

class TalkDataRepository implements TalkRepository {
  @override
  Future<List<Talk>> loadAll() async {
    return [
      Talk(title: "teste"),
      Talk(title: "teste1"),
      Talk(title: "teste2"),
      Talk(title: "teste3"),
      Talk(title: "teste4")
    ];
  }
}
