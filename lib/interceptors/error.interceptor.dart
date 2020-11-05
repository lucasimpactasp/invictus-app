import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/utils/banner/banner.utils.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    String title = 'Error';
    String text = 'Erro desconhecido';

    if (err.response != null) {
      text = err.response.toString();
    }

    if (err.response.data != null) {
      text = err.response.data.toString();
    }

    if (err.response.data['message'] != null) {
      text = err.response.data['message'].toString();
    }

    if (err.response.data['statusCode'] != null) {
      title = 'Código de erro: ${err.response.data['statusCode']}';
    }

    print('${err.message} ${err.error} ${err.response}');

    if (Get.currentRoute == '/') {
      BannerUtils.showErrorBanner(
        text,
        title: title,
        backgroundColor: Colors.white,
        colorText: Colors.redAccent,
      );
    } else {
      BannerUtils.showErrorBanner(
        text,
        title: title,
      );
    }
    return super.onError(err);
  }
}
