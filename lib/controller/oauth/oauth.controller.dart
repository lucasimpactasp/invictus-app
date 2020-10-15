import 'package:get/get.dart';
import 'package:invictus/services/oauth/oauth.service.dart';
import 'package:oauth_dio/oauth_dio.dart';

class OAuthController extends GetxController {
  Rx<OAuthToken> token = OAuthToken().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<OAuthToken> getToken(String username, String password) async {
    final OAuthToken tokenRes = await oAuthService.login(username, password);
    token.value = tokenRes;

    return tokenRes;
  }
}
