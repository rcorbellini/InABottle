// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_message_storage.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DirectMessageService implements DirectMessageService {
  _DirectMessageService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final  d.Dio _dio;

  String baseUrl;

  @override
  delete(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final d.Response _result = await _dio.request('/direct/$key',
        queryParameters: queryParameters,
        options:  d.RequestOptions(
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
    final  d.Response _result = await _dio.post("/direct", data:entity.toMap() ?? <String, dynamic>{}, 
         options:  d.RequestOptions(contentType: d.Headers.jsonContentType, baseUrl: baseUrl ));
    return _result.data.toString();
  }

  @override
  loadAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final  d.Response<List<dynamic>> _result = await _dio.request(
        '/direct',
        queryParameters: queryParameters,
        options:  d.RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => DirectMessage.fromMap(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  loadByKey(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final  d.Response<Map<String, dynamic>> _result = await _dio.request(
        '/direct/$key',
        queryParameters: queryParameters,
        options:  d.RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DirectMessage.fromMap(_result.data);
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
    final  d.Response<Map<String, dynamic>> _result = await _dio.request(
        '/direct/$key',
        queryParameters: queryParameters,
        options:  d.RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DirectMessage.fromMap(_result.data);
    return value;
  }
}
