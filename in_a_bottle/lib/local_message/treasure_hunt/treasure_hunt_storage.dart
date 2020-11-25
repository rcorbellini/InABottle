import 'package:dio/dio.dart';
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' as d;
import 'dart:convert';

part 'treasure_hunt_storage.g.dart';

abstract class TreasureHuntStorage
    implements BaseDataStorage<TreasureHunt, String> {}

class TreasureHuntDao extends BaseDao<TreasureHunt>
    implements TreasureHuntStorage {
  @override
  TreasureHunt fromJson(map) => TreasureHunt.fromMap(map);

  @override
  String get path => "treasure_hunt";

  @override
  Map<String, dynamic> toJson(TreasureHunt entity) => entity.toMap();
}

@RestApi()
abstract class TreasureHuntService implements TreasureHuntStorage {
  factory TreasureHuntService(Dio dio, {String baseUrl}) =
      _TreasureHuntService;

  @DELETE("/treasure_hunt/{key}")
  @override
  Future delete(@Path() String key);

  @POST("/treasure_hunt")
  @override
  Future<String> insert(TreasureHunt entity);

  @GET("/treasure_hunt")
  @override
  Future<List<TreasureHunt>> loadAll();

  @GET("/treasure_hunt/{key}")
  @override
  Future<TreasureHunt> loadByKey(@Path("key") String key);

  @PUT("/treasure_hunt/{key}")
  Future<TreasureHunt> update(@Path() String key, @Body() TreasureHunt task);
}
