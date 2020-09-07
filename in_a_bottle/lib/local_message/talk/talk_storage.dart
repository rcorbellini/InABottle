
import 'package:dio/dio.dart';
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:retrofit/retrofit.dart';

part 'talk_storage.g.dart';

abstract class TalkStorage implements BaseDataStorage<Talk, String> {}

class TalkDao extends BaseDao<Talk> implements TalkStorage {
  @override
  Talk fromJson(map) => Talk.fromMap(map);

  @override
  String get path => "talk";

  @override
  Map<String, dynamic> toJson(Talk entity) => entity.toMap();
}



@RestApi()
abstract class TalkService implements TalkStorage {
  factory TalkService(Dio dio, {String baseUrl}) = _TalkService;

  @DELETE("/talk/{key}")
  @override
  Future delete(@Path() String key);

  @POST("/talk")
  @override
  Future insert(Talk entity);

  @GET("/talk")
  @override
  Future<List<Talk>> loadAll();

  @GET("/talk/{key}")
  @override
  Future<Talk> loadByKey(@Path("key") String key);

  @PUT("/talk/{key}")
  Future<Talk> update(@Path() String key, @Body() Talk task);
}
