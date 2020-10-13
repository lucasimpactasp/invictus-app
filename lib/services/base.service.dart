import 'package:dio/dio.dart';

abstract class BaseService<T> {
  String baseUrl = 'http://localhost:3000';

  Future<dynamic> getOne(String id, {Map<String, dynamic> params}) async {
    final response = await Dio().get('$baseUrl/${T.toString().toLowerCase()}/$id', queryParameters: params).catchError((error) => throw (error));

    if(response == null) {
      throw ('Error to get $id from ${T.toString()}');
    }

    return response.data;
  }

  Future<List<dynamic>> getMany({Map<String, dynamic> params}) async {
    print('$baseUrl/${T.toString()}');
    final response = await Dio().get('$baseUrl/${T.toString().toLowerCase()}', queryParameters: params).catchError((error) => throw (error));

    if(response == null) {
      throw ('Error to get many from ${T.toString().toLowerCase()}');
    }

    return response.data;
  }
}