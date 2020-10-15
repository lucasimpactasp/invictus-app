import 'package:dio/dio.dart';

abstract class BaseService {
  String baseUrl = 'http://localhost:3000';

  String endpoint;

  BaseService(this.endpoint);

  Future<dynamic> getOne(String id, {Map<String, dynamic> params}) async {
    final response = await Dio()
        .get('$baseUrl/$endpoint/$id', queryParameters: params)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get $id from $endpoint');
    }

    return response.data;
  }

  Future<List<dynamic>> getMany({Map<String, dynamic> params}) async {
    final response = await Dio()
        .get('$baseUrl/$endpoint', queryParameters: params)
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get many from $endpoint');
    }

    return response.data;
  }
}
