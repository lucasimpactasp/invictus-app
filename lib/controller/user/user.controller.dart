import 'package:get/get.dart';
import 'package:invictus/services/user/user.service.dart';

class UserController extends GetxController {
  RxMap user = {}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future getUser() async {
    final userRes = await userService.getOne('me');
    user.value = userRes;
    print('aaaaaaaaaaaaaaa $userRes');

    return userRes;
  }
}