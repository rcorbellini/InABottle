// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_message_storage.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _HubMessageService implements HubMessageService {
  _HubMessageService(this._dio, {this.baseUrl}) {
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
    final Response _result = await _dio.request('/hub_message/$key',
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
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request('/hub_message',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  loadAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/hub_message',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => HubMessage.fromMap(i as Map<String, dynamic>))
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
        '/hub_message/$key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HubMessage.fromMap(_result.data);
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
        '/hub_message/$key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HubMessage.fromMap(_result.data);
    return value;
  }
}
