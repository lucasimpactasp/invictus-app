import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  final String separator =
      '=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=';

  @override
  Future onRequest(RequestOptions options) async {
    String url = '';

    if (options.baseUrl != null) {
      url += options.baseUrl;
    }

    if (options.path != null) {
      url += options.path;
    }

    if (options.queryParameters.isNotEmpty) {
      options.queryParameters.entries.forEach((element) {
        url += '?${element.key}=${element.value}';
      });
    }

    print('Fazendo requisiçao');
    print('$separator\n[HttpLogger::${options.method}] --> $url\n$separator\n');

    if (options.headers.isNotEmpty) {
      print('[HEADERS]\n$separator');
      options.headers.entries.forEach((item) {
        print('Key: ${item.key} | Value: ${item.value}\n');
      });
    }

    if (options.method == 'POST' || options.method == 'PUT') {
      print('${options.data}\n$separator\n');
    }

    return options;
  }

  @override
  Future onResponse(Response response) async {
    print(
        '$separator\n[HttpLogger::${response.request.method}] <-- ${response.data}\n$separator\n');
    print('Recebida resposta');

    return response;
  }
}
