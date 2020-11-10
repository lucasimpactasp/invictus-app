import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/services/base.service.dart';

class _UserService extends BaseService<User> {
  String endpoint;

  _UserService({this.endpoint = 'users'}) : super(endpoint);

  Future<User> getBestSeller() async {
    final response = await this
        .get('/$endpoint/bestSeller')
        .catchError((error) => throw (error));

    if (response.data == null || response.data.isEmpty) {
      return null;
    }

    final res = response.data;

    return fromJson(res);
  }

  Future<List<User>> search(Map<String, dynamic> body) async {
    final response = await this
        .post('/$endpoint/search', data: body)
        .catchError((error) => throw (error));

    if (response.data == null || response.data.isEmpty) {
      return null;
    }

    final res = response.data;

    return res.map((user) => fromJson(user)).toList();
  }

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
