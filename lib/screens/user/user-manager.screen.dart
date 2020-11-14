import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/controller/vendor/vendor.controller.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/core/widgets/input/input.widget.dart';
import 'package:invictus/main.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/services/user/user.service.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:menu_button/menu_button.dart';

class UserManagerScreen extends StatefulWidget {
  final User user;

  UserManagerScreen({this.user});

  @override
  _UserManagerScreenState createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _radioValue = 'M';
  String selectedItem = 'employee';

  List<String> items = ['admin', 'employee', 'default'];

  @override
  void initState() {
    super.initState();

    loadForm();
  }

  void loadForm() {
    if (widget.user != null) {
      this.nameController.text = widget.user.firstName;
      this.lastNameController.text = widget.user.lastName;
      this.emailController.text = widget.user.email;
      this.usernameController.text = widget.user.username;

      setState(() {
        selectedItem = widget.user.role;
        _radioValue = widget.user.gender;
      });
    }
  }

  void onChangeRadio(Object value) {
    print(value);
  }

  void _handleRadioValueChange(String value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Widget button = SizedBox(
      width: double.infinity,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                selectedItem,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: InvictusAppBar.getAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await userService.deleteOne(widget.user.id);
            Get.to(Home());
          },
          heroTag: null,
          backgroundColor: theme.primaryColor,
          child: Icon(Icons.delete_outline),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              Form(
                child: Column(
                  children: [
                    Input(
                      controller: nameController,
                      labelText: 'Primeiro Nome',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Input(
                        controller: lastNameController,
                        labelText: 'Sobrenome',
                      ),
                    ),
                    Input(
                      controller: usernameController,
                      labelText: 'Usuário',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 6,
                      ),
                      child: Input(
                        controller: emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    if (InvictusApp.role == 'admin') ...{
                      MenuButton(
                        child: button, // Widget displayed as the button
                        items: items, // List of your items
                        topDivider: true,
                        label: Text('Cargo'),
                        scrollPhysics:
                            AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                        itemBuilder: (value) => Container(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          height: 40,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(value),
                        ), // Widget displayed for each item
                        toggledChild: Container(
                          color: Colors.white,
                          child: button, // Widget displayed as the button,
                        ),
                        divider: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        onItemSelected: (value) {
                          selectedItem = value;
                          // Action when new item is selected
                        },
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.0)),
                            color: Colors.white),
                        onMenuButtonToggle: (isToggle) {
                          print(isToggle);
                        },
                      ),
                    } else ...{
                      Text('Cargo: ${widget.user.role}')
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 'M',
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                          activeColor: theme.primaryColor,
                        ),
                        new Text('Homem'),
                        new Radio(
                          value: 'F',
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                          activeColor: theme.primaryColor,
                        ),
                        new Text('Mulher'),
                      ],
                    ),
                    if (widget.user == null || InvictusApp.role == 'admin') ...{
                      Input(
                        controller: passwordController,
                        labelText: 'Senha',
                        obscureText: true,
                      ),
                    },
                    InvictusButton(
                      backgroundColor: theme.primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        String text = 'Usuário criado com sucesso!';

                        final UserController userController = Get.put(
                          UserController(),
                        );

                        final UserParams userParams = UserParams(
                          email: emailController.text,
                          firstName: nameController.text,
                          lastName: lastNameController.text,
                          gender: _radioValue,
                          password: passwordController.text,
                          role: selectedItem,
                          username: usernameController.text,
                        );

                        if (widget.user != null) {
                          await userController.updateUser(
                            widget.user.id,
                            userParams,
                          );

                          text = 'Usuário alterado com sucesso!';
                        } else {
                          await userController.createUser(userParams);
                        }

                        Get.offAll(Home());

                        BannerUtils.showBanner('Feito!', text);
                      },
                      title: widget.user != null
                          ? 'Editar usuário'
                          : 'Cadastrar usuário',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
