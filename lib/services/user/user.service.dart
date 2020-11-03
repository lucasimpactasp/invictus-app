import 'package:invictus/services/base.service.dart';

class _UserService extends BaseService {
  String endpoint;

  _UserService({this.endpoint = 'users'}) : super(endpoint);
}

final userService = _UserService();
