import 'package:get/get.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/services/invoice/invoice.service.dart';

class InvoiceController extends GetxController {
  RxList<Invoice> invoices = <Invoice>[].obs;
  Rx<Invoice> invoice = Invoice().obs;

  Future<List<Invoice>> getInvoices() async {
    final List<Invoice> invoices = await invoiceService.getMany();
    this.invoices.value = invoices;

    return invoices;
  }

  Future<Invoice> createInvoice(CreateInvoice body) async {
    final Invoice invoice = await invoiceService.postOne(body.toJson());
    this.invoice.value = invoice;

    return invoice;
  }
}
