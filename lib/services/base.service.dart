import 'package:dio/dio.dart';
import 'package:invictus/services/oauth/oauth.service.dart';
import 'package:oauth_dio/oauth_dio.dart';

abstract class BaseService<T> {
  final String baseUrl = 'http://localhost:3000';

  String endpoint;
  Dio dio;

  BaseService(this.endpoint) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    dio.interceptors.add(BearerInterceptor(oauth));
  }

  Future<T> getOne(String id, {Map<String, dynamic> params}) async {
    final response = await dio
        .get('/$endpoint/$id', queryParameters: params)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get $id from $endpoint');
    }

    return response.data;
  }

  Future<List<T>> getMany({Map<String, dynamic> params}) async {
    final response = await dio
        .get('/$endpoint', queryParameters: params)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get many from $endpoint');
    }

    return response.data;
  }

  Future postOne(Map<String, dynamic> body) async {
    final response = await dio
        .post('/$endpoint', data: body)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to post one from $endpoint');
    }

    return response.data;
  }
}
