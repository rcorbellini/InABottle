import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:in_a_bottle/adapters/archtecture/base_dao.dart';
import 'package:in_a_bottle/adapters/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/treasure_hunt.dart';
import 'package:retrofit/retrofit.dart';


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

class TreasureHuntService implements TreasureHuntStorage {
  final http.Client client = http.Client();
  @override
  Future delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<String> insert(TreasureHunt entity) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<List<TreasureHunt>> loadAll() {
    // TODO: implement loadAll
    throw UnimplementedError();
  }

  @override
  Future<TreasureHunt> loadByKey(String key) {
    // TODO: implement loadByKey
    throw UnimplementedError();
  }

  @override
  Future update(String key, TreasureHunt entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

}
