import 'package:geochat/_shared/archtecture/base_repository.dart';
import 'package:geochat/local_message/message/direct_message_dto.dart';

abstract class MessageRepository
    implements BaseRepository<DirectMessage, String> {}

class MessageDataRepository extends MessageRepository{

  @override
  Future delete() {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<DirectMessage>> loadAll() async{
    // TODO: implement loadAll
    return [];
  }

  @override
  Future<DirectMessage> loadByKey(String key) {
    // TODO: implement loadByKey
    return null;
  }

  @override
  Future save() {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll() {
    // TODO: implement saveAll
    return null;
  }

}