import 'package:get/get.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/services/user/user.service.dart';

class UserController extends GetxController {
  Rx<User> user = User().obs;

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
}
