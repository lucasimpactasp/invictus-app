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
}
