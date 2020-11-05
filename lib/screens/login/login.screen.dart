import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/services/oauth/oauth.service.dart';
import 'package:oauth_dio/oauth_dio.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() => loading = true);

    final OAuthToken token = await oauth.fetchOrRefreshAccessToken();

    setState(() => loading = false);

    if (token != null) {
      final UserController userController = Get.put(UserController());
      setState(() => loading = true);

      await userController.getUser();

      setState(() => loading = false);

      if (token != null && token.refreshToken != null) {
        Get.offAllNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Usuário'),
                        controller: usernameController,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Senha'),
                        controller: passwordController,
                        obscureText: true,
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async {
                            await oAuthService.login(
                              usernameController.value.text,
                              passwordController.value.text,
                            );

                            Get.offAllNamed('/home');
                          },
                          color: theme.primaryColor,
                          child: Text(
                            'Entrar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
