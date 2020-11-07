import 'package:get/get.dart';
import 'package:invictus/core/models/vendor/vendor.model.dart';
import 'package:invictus/services/vendor/vendor.service.dart';

class VendorController extends GetxController {
  RxList<Vendor> vendors = <Vendor>[].obs;

  Future<List<Vendor>> getVendors() async {
    final vendors = await vendorService.getMany();
    this.vendors.value = vendors;

    return vendors;
  }

  Future<Vendor> getVendor(String id, {Map<String, dynamic> params}) async {
    final vendor = await vendorService.getOne(
      id,
      params: params,
    );

    return vendor;
  }

  Future<Vendor> updateVendor(String id, VendorParams body) async {
    final vendor = await vendorService.putOne(id, body.toJson());
    return vendor;
  }

  Future<Vendor> createVendor(VendorParams body) async {
    final vendor = await vendorService.postOne(body.toJson());
    return vendor;
  }
}
