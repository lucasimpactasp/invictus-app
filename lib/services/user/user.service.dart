import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/services/base.service.dart';

class _UserService extends BaseService<User> {
  String endpoint;

  _UserService({this.endpoint = 'users'}) : super(endpoint);

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(User item) {
    return item.toJson();
  }
}

final userService = _UserService();
