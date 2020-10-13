import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/services/oauth/oauth.service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: ListView(
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
                      await oAuthService.login(usernameController.value.text,
                          passwordController.value.text);

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
