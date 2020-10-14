import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:invictus/utils/storage/storage.utils.dart';
import 'package:oauth_dio/oauth_dio.dart';

class _OAuthService {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String clientId = '433535ea-a184-4bd2-9f51-4570441bfb07';
  final String clientSecret = 'invictus';

  Future login(String username, String password) async {
    final OAuth oAuth = _getOAuth();

    OAuthToken token = await oAuth
        .requestToken(
          PasswordGrant(
            username: username,
            password: password,
            scope: ['public'],
          ),
        )
        .catchError((error) => throw(error));

    await StorageUtils.saveOrGet('accessToken', value: token.accessToken);
    await StorageUtils.saveOrGet('refreshToken', value: token.refreshToken);

    return token;

  }

  OAuth _getOAuth() {
    return OAuth(
      clientId: clientId,
      clientSecret: clientSecret,
      tokenUrl: 'http://localhost:3000/oauth/token',
    );
  }
}

final oAuthService = _OAuthService();
