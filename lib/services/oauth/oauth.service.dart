import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/services/base.service.dart';
import 'package:invictus/utils/storage/storage.utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oauth_dio/oauth_dio.dart';

final OAuth oauth = OAuth(
  tokenUrl: 'http://localhost:3000/oauth/token',
  clientId: '433535ea-a184-4bd2-9f51-4570441bfb07',
  clientSecret: 'invictus',
  storage: OAuthSecureStorage(),
  validator: (token) async => JwtDecoder.isExpired(token.accessToken),
);

class OAuthSecureStorage extends OAuthStorage {
  @override
  Future<void> clear() async {
    await StorageUtils.delete('accessToken');
    await StorageUtils.delete('refreshToken');
  }

  @override
  Future<OAuthToken> fetch() async {
    final accessToken = await StorageUtils.saveOrGet('accessToken');
    final refreshToken = await StorageUtils.saveOrGet('refreshToken');

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return OAuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<OAuthToken> save(OAuthToken token) async {
    print(token);
    await StorageUtils.saveOrGet('accessToken', value: token.accessToken);
    await StorageUtils.saveOrGet('refreshToken', value: token.refreshToken);

    return token;
  }
}

class TicketGrant extends OAuthGrantType {
  final String accessToken;

  TicketGrant({this.accessToken});

  @override
  RequestOptions handle(RequestOptions request) {
    request.data = 'grant_type=ticket&access_token=$accessToken';
    return request;
  }
}

class _OAuthService extends BaseService {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String clientId = '433535ea-a184-4bd2-9f51-4570441bfb07';
  final String clientSecret = 'invictus';

  String endpoint;

  _OAuthService({this.endpoint = 'oauth'}) : super(endpoint);

  Future login(String username, String password) async {
    OAuthToken token = await oauth.requestToken(
      PasswordGrant(
        username: username,
        password: password,
        scope: [],
      ),
    );

    final UserController userController = Get.put(UserController());

    await oauth.storage.save(token);
    await userController.getUser();
    return token;
  }

  Future logout() async {
    await oauth.storage.clear();
  }

  @override
  Model fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(Model item) {
    throw UnimplementedError();
  }
}

final oAuthService = _OAuthService();
