import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/vendor/vendor.model.dart';
import 'package:invictus/services/base.service.dart';

class _VendorService extends BaseService<Vendor> {
  String endpoint;

  _VendorService({this.endpoint = 'vendors'}) : super(endpoint);

  @override
  Vendor fromJson(Map<String, dynamic> json) {
    return Vendor.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Vendor item) {
    return item.toJson();
  }
}

final vendorService = _VendorService();
