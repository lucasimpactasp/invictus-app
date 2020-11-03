import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/services/oauth/oauth.service.dart';

class InvictusAppBar {
  static AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      title: Text(
        'Invictus App',
      ),
      centerTitle: true,
      actions: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              'Sair',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.offAllNamed('/login');
            oAuthService.logout();
          },
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
