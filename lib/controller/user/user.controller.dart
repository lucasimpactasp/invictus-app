import 'package:get/get.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/services/user/user.service.dart';

class UserController extends GetxController {
  Rx<User> user = User().obs;
  RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future getUser() async {
    final userRes = await userService.getOne('me');
    user.value = userRes;

    return userRes;
  }

  Future getBestSeller() async {
    final userRes = await userService.getBestSeller();
    user.value = userRes;

    return userRes;
  }

  Future<User> createUser(UserParams body) async {
    final user = await userService.postOne(body.toJson());
    this.user.value = user;

    return user;
  }

  Future<User> updateUser(String id, UserParams body) async {
    final user = await userService.putOne(id, body.toJson());
    this.user.value = user;

    return user;
  }

  Future<List<User>> searchUser(Map<String, dynamic> body) async {
    final users = await userService.search(body);
    this.users.value = users;
    return users;
  }

  Future<List<User>> getUsers() async {
    final users = await userService.getMany(params: {'join': 'madeInvoices'});
    this.users.value = users;
    return users;
  }
}
