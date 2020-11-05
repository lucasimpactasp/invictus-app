import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/services/base.service.dart';

class _InvoiceService extends BaseService<Invoice> {
  String endpoint;

  _InvoiceService({this.endpoint = 'invoice'}) : super(endpoint);

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
