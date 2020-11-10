import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/input/input.widget.dart';
import 'package:invictus/screens/user/user-manager.screen.dart';
import 'package:invictus/utils/debounce/debounce.util.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserController userController = Get.put(UserController());
  final TextEditingController searchController = TextEditingController();
  final Debounce debounce = Debounce(Duration(milliseconds: 500));

  @override
  void initState() {
    userController.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed('/product-manager');
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Vendedores',
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: Input(
                        controller: searchController,
                        labelText: 'Digite o nome de usuário do vendedor',
                        rounded: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: theme.primaryColor,
                        ),
                        onChanged: (String term) {
                          debounce.run(() async {
                            return await userController
                                .searchUser({'username': term});
                          }).onCancel(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                print('aaaaaaaaaaaaaaaaaaaa');
                print(userController.users.value.isNull);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: userController.users == null
                      ? []
                      : userController.users.map(
                          (user) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  UserManagerScreen(
                                    user: user,
                                  ),
                                );
                              },
                              child: Container(
                                margin: userController.users.last == user
                                    ? EdgeInsets.symmetric(horizontal: 24)
                                    : EdgeInsets.all(24),
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 8,
                                      offset: Offset.zero,
                                      spreadRadius: .3,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              user.firstName ?? '',
                                              style: theme.textTheme.headline6,
                                            ),
                                            Text(
                                              " ${user.lastName ?? ''}",
                                              style: theme.textTheme.headline6,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          user.username,
                                          style: theme.textTheme.caption,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                              'Vendas: ${user.madeInvoices.length}'),
                                        )
                                      ],
                                    ),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      color: theme.primaryColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
