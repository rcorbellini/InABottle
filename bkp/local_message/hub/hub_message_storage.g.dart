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
    final Response _result = await _dio.request('/hub/$key',
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
    final d.Response _result = await _dio.post("/hub",
        data: entity.toMap() ?? <String, dynamic>{},
        options: d.RequestOptions(
            contentType: d.Headers.jsonContentType, baseUrl: baseUrl));
    return _result.data.toString();
  }

  @override
  loadAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/hub',
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
        '/hub/$key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{'Keep-Alive': true},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HubMessage.fromMap(_result.data);
    return value;
  }

  @override
  update(key, entity) async {
    throw Exception("Nao implementado");
  }


  addMessage(key, entity)async {
    ArgumentError.checkNotNull(entity, 'entity');
    final entityMessage = entity.toMap();
    final d.Response _result = await _dio.post("/hub/$key/addMessage",
        data: entityMessage ?? <String, dynamic>{},
        options: d.RequestOptions(
            headers: <String, dynamic>{'Keep-Alive': true},
            contentType: d.Headers.jsonContentType,
            baseUrl: baseUrl));
    return _result.data.toString();
  }

  
  addReaction(String hubKey, String messageKey, UserReaction entity) async{
        ArgumentError.checkNotNull(entity, 'entity');
    final entityMessage = entity.toMap();
    final d.Response _result = await _dio.post("/hub/$hubKey/message/$messageKey/addReaction",
        data: entityMessage ?? <String, dynamic>{},
        options: d.RequestOptions(
            headers: <String, dynamic>{'Keep-Alive': true},
            contentType: d.Headers.jsonContentType,
            baseUrl: baseUrl));
    return _result.data.toString();
  }

   removeReaction(String hubKey, String messageKey, UserReaction entity) async{
        ArgumentError.checkNotNull(entity, 'entity');
    final entityMessage = entity.toMap();
    final d.Response _result = await _dio.delete("/hub/$hubKey/message/$messageKey/removeReaction",
        data: entityMessage ?? <String, dynamic>{},
        options: d.RequestOptions(
            headers: <String, dynamic>{'Keep-Alive': true},
            contentType: d.Headers.jsonContentType,
            baseUrl: baseUrl));
    return _result.data.toString();
  }
}
