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
        GestureDetector(
          onTap: () {
            Get.offAllNamed('/login');
            oAuthService.logout();
          },
          child: Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                  ),
                  child: Text(
                    'Sair',
                  ),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
