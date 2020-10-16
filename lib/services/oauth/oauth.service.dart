import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:invictus/services/base.service.dart';
import 'package:invictus/utils/storage/storage.utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oauth_dio/oauth_dio.dart';

import '../../main.dart';

final OAuth oauth = OAuth(
  tokenUrl: 'http://10.0.2.2:3000/oauth/token',
  clientId: '433535ea-a184-4bd2-9f51-4570441bfb07',
  clientSecret: 'invictus',
  storage: OAuthSecureStorage(),
  validator: (token) async => JwtDecoder.isExpired(token.accessToken),
);

class OAuthSecureStorage extends OAuthStorage {
  @override
  Future<void> clear() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
  }

  @override
  Future<OAuthToken> fetch() async {
    final accessToken = await storage.read(key: 'accessToken');
    final refreshToken = await storage.read(key: 'refreshToken');

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
    await storage.write(key: 'accessToken', value: token.accessToken);
    await storage.write(key: 'refreshToken', value: token.refreshToken);

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
    OAuthToken token = await oauth
        .requestToken(
          PasswordGrant(
            username: username,
            password: password,
            scope: ['public'],
          ),
        )
        .catchError((error) => throw (error.response.data));

    await StorageUtils.saveOrGet('accessToken', value: token.accessToken);
    await StorageUtils.saveOrGet('refreshToken', value: token.refreshToken);

    return token;
  }
}

final oAuthService = _OAuthService();
