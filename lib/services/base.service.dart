import 'package:dio/dio.dart';
import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/interceptors/error.interceptor.dart';
import 'package:invictus/interceptors/logger.interceptor.dart';
import 'package:invictus/services/oauth/oauth.service.dart';
import 'package:oauth_dio/oauth_dio.dart';

abstract class BaseService<T extends Model> {
  final String baseUrl = 'http://10.0.2.2:3000';

  String endpoint;
  static Dio _dio;

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);

  BaseService(this.endpoint) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    _dio.interceptors.add(BearerInterceptor(oauth));
    _dio.interceptors.add(ErrorInterceptor());
    _dio.interceptors.add(LoggerInterceptor());
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<T> getOne(String id, {Map<String, dynamic> params}) async {
    final response = await this
        .get('/$endpoint/$id?join=products', queryParameters: params)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get $id from $endpoint');
    }

    return fromJson(response.data);
  }

  Future<List<T>> getMany({Map<String, dynamic> params}) async {
    final response = await _dio
        .get('/$endpoint', queryParameters: params)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get many from $endpoint');
    }

    final List res = response.data;

    return res.map((e) => fromJson(e)).toList();
  }

  Future<T> postOne(Map<String, dynamic> body) async {
    final response = await _dio
        .post('/$endpoint', data: body)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to create one from $endpoint');
    }

    return fromJson(response.data);
  }

  Future<T> putOne(String id, Map<String, dynamic> body) async {
    final response = await _dio
        .put('/$endpoint/$id', data: body)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to update from $endpoint');
    }

    return fromJson(response.data);
  }
}
