import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/core/widgets/input/input.widget.dart';
import 'package:invictus/main.dart';
import 'package:invictus/services/oauth/oauth.service.dart';
import 'package:oauth_dio/oauth_dio.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode userFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

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

      final user = await userController.getUser();
      InvictusApp.role = user.role;

      setState(() => loading = false);

      if (token != null && token.refreshToken != null) {
        Get.offAllNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(
                FocusNode(),
              ),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height / 2,
                    alignment: Alignment.center,
                    color: theme.primaryColor,
                    child: Container(
                      child: Image(
                        image: AssetImage('assets/logo_black.png'),
                      ),
                    ),
                  ),
                  Container(
                    color: theme.scaffoldBackgroundColor,
                    padding: EdgeInsets.only(left: 24, right: 24),
                    height: size.height / 2,
                    alignment: Alignment.center,
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Input(
                            controller: usernameController,
                            labelText: 'Usuário',
                            focusNode: userFocus,
                            onSubmitted: (String value) {
                              passwordFocus.requestFocus();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 12,
                            ),
                            child: Input(
                              controller: passwordController,
                              focusNode: passwordFocus,
                              labelText: 'Senha',
                              onSubmitted: (String value) => this.login(),
                              obscureText: true,
                            ),
                          ),
                          InvictusButton(
                            backgroundColor: theme.primaryColor,
                            textColor: Colors.white,
                            onPressed: this.login,
                            title: 'Entrar',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  login() async {
    await oAuthService.login(
      usernameController.value.text,
      passwordController.value.text,
    );

    Get.offAllNamed('/home');
  }
}
