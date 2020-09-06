import 'package:dio/dio.dart';
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:retrofit/retrofit.dart';

part 'direct_message_storage.g.dart';

abstract class DirectMessageStorage
    implements BaseDataStorage<DirectMessage, String> {}

class DirectMessageDao extends BaseDao<DirectMessage>
    implements DirectMessageStorage {
  @override
  DirectMessage fromJson(map) => DirectMessage.fromMap(map);

  @override
  String get path => "direct_message";

  @override
  Map<String, dynamic> toJson(DirectMessage entity) => entity.toMap();
}

@RestApi()
abstract class DirectMessageService implements DirectMessageStorage {
  factory DirectMessageService(Dio dio, {String baseUrl}) =
      _DirectMessageService;

  @DELETE("/direct_message/{key}")
  @override
  Future delete(@Path() String key);

  @POST("/direct_message")
  @override
  Future insert(DirectMessage entity);

  @GET("/direct_message")
  @override
  Future<List<DirectMessage>> loadAll();

  @GET("/direct_message/{key}")
  @override
  Future<DirectMessage> loadByKey(@Path("key") String key);

  @PUT("/direct_message/{key}")
  Future<DirectMessage> update(@Path() String key, @Body() DirectMessage task);
}
