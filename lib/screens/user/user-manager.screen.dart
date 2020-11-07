import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/controller/vendor/vendor.controller.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/screens/home/home.screen.dart';
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
      width: MediaQuery.of(context).size.width / 2 - 24,
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
        body: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Primeiro Nome',
                    ),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Sobrenome',
                    ),
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'username',
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MenuButton(
                    child: button, // Widget displayed as the button
                    items: items, // List of your items
                    topDivider: true,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 'M',
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text('Homem'),
                      new Radio(
                        value: 'F',
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text('Mulher'),
                    ],
                  ),
                  if (widget.user == null) ...{
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                      ),
                      obscureText: true,
                    ),
                  },
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: theme.primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: RaisedButton(
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
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      color: Colors.transparent,
                      child: Text(
                        widget.user != null
                            ? 'Editar usuário'
                            : 'Cadastrar usuário',
                        style: theme.textTheme.bodyText2.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
