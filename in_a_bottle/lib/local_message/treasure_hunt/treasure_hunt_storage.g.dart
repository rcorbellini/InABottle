// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treasure_hunt_storage.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TreasureHuntService implements TreasureHuntService {
  _TreasureHuntService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  delete(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request('/treasure_hunt/$key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  insert(entity) async {
    ArgumentError.checkNotNull(entity, 'entity');
    //print(json.encode(entity.toMap()));
    final  d.Response _result = await _dio.post("/treasure", data:entity.toMap() ?? <String, dynamic>{}, 
         options:  d.RequestOptions(contentType: d.Headers.jsonContentType, baseUrl: baseUrl ));
    return _result.data.toString();
  }


  @override
  loadAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/treasure',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => TreasureHunt.fromMap(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  loadByKey(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/treasure_hunt/$key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TreasureHunt.fromMap(_result.data);
    return value;
  }

  @override
  update(key, task) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(task, 'task');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(task?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/treasure_hunt/$key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TreasureHunt.fromMap(_result.data);
    return value;
  }
}
