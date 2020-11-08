import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/services/base.service.dart';

class _InvoiceService extends BaseService<Invoice> {
  String endpoint;

  _InvoiceService({this.endpoint = 'invoice'}) : super(endpoint);

  Future<List<Invoice>> searchByTitle({Map<String, dynamic> data}) async {
    final response = await this
        .post(
          '/$endpoint/search',
          data: data,
        )
        .catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to search from $endpoint');
    }

    final List res = response.data;

    return res.map((e) => fromJson(e)).toList();
  }

  @override
  Invoice fromJson(Map<String, dynamic> json) {
    return Invoice.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Invoice item) {
    return item.toJson();
  }
}

final invoiceService = _InvoiceService();
