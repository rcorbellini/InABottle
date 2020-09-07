import 'package:dio/dio.dart';
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:retrofit/retrofit.dart';

part 'hub_message_storage.g.dart';


abstract class HubMessageStorage
    implements BaseDataStorage<HubMessage, String> {}

class HubMessageDao extends BaseDao<HubMessage> implements HubMessageStorage {
  @override
  HubMessage fromJson(map) => HubMessage.fromMap(map);

  @override
  String get path => "chat";

  @override
  Map<String, dynamic> toJson(HubMessage entity) => entity.toMap();
}

@RestApi()
abstract class HubMessageService implements HubMessageStorage {
  factory HubMessageService(Dio dio, {String baseUrl}) = _HubMessageService;

  @DELETE("/hub_message/{key}")
  @override
  Future delete(@Path() String key);

  @POST("/hub_message")
  @override
  Future insert(HubMessage entity);

  @GET("/hub_message")
  @override
  Future<List<HubMessage>> loadAll();

  @GET("/hub_message/{key}")
  @override
  Future<HubMessage> loadByKey(@Path("key") String key);

  @PUT("/hub_message/{key}")
  Future<HubMessage> update(@Path() String key, @Body() HubMessage task);
}
