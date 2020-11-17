import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/payment/invoice.controller.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/invoice/installment.model.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/core/widgets/input/input.widget.dart';
import 'package:invictus/core/widgets/payment/payment-parcels.widget.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class InvoiceManager extends StatefulWidget {
  final Invoice invoice;

  InvoiceManager({
    this.invoice,
  });

  @override
  _InvoiceManagerState createState() => _InvoiceManagerState();
}

class _InvoiceManagerState extends State<InvoiceManager> {
  final TextEditingController titleController = TextEditingController();
  final MoneyMaskedTextController discountController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final MoneyMaskedTextController totalController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final TextEditingController quantityController =
      TextEditingController(text: '1');

  final InvoiceController invoiceController = Get.put(InvoiceController());
  final ProductController productController = Get.put(ProductController());

  List<Installment> installments = [];
  List<String> products = [];

  Invoice invoice;
  bool showProducts = true;

  @override
  void initState() {
    super.initState();

    if (widget.invoice != null) {
      loadForm();
    }
  }

  void loadForm() async {
    final invoice = await invoiceController.getInvoice(widget.invoice.id);

    this.titleController.text = invoice.title;
    this.discountController.updateValue(invoice.discount / 100);
    this.totalController.updateValue(invoice.total / 100);
    invoice.installments.sort(
      (a, b) =>
          a.expirationDate.millisecondsSinceEpoch -
          b.expirationDate.millisecondsSinceEpoch,
    );

    setState(() {
      this.invoice = invoice;
      this.installments = invoice.installments;
      this.products = invoice.products.map((e) => e.id).toList();
      this.showProducts = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      body: Container(
        margin: EdgeInsets.all(24),
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  Input(
                    controller: titleController,
                    enabled: widget.invoice == null,
                    labelText: 'Título',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Input(
                      controller: quantityController,
                      enabled: widget.invoice == null,
                      labelText: 'Quantidade de produtos',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: PaymentParcel(
                      valueController: totalController,
                      invoice: invoice,
                      onUpdateParcels: (List<Installment> installmentsRes) {
                        setState(() => installments = installmentsRes);
                      },
                    ),
                  ),
                  Obx(() {
                    if (productController.productsValue != null &&
                        productController.productsValue.length > 0 &&
                        showProducts) {
                      return Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          chipBackGroundColor: theme.primaryColor,
                          chipLabelStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: theme.primaryColor,
                          checkBoxCheckColor: Colors.white,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          dialogShapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          title: Text(
                            'Produtos da venda',
                            style: TextStyle(fontSize: 16),
                          ),
                          dataSource: productController.productsValue
                              .map((e) => e.toJson(addId: true))
                              .toList(),
                          textField: 'name',
                          valueField: 'id',
                          okButtonLabel: 'Adicionar',
                          cancelButtonLabel: 'Cancelar',
                          hintWidget: Text('Clique para selecionar'),
                          initialValue: this.products,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              this.products = value
                                  .map<String>((v) => v.toString())
                                  .toList();
                            });
                          },
                        ),
                      );
                    }

                    return Container();
                  }),
                  if (widget.invoice == null) ...{
                    Container(
                      width: double.infinity,
                      child: InvictusButton(
                        backgroundColor: theme.primaryColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          this.installments.forEach((installment) {
                            installment.title = titleController.text;
                          });

                          final CreateInvoice invoice = CreateInvoice(
                            title: titleController.text,
                            installments: this.installments,
                            products: this.products,
                            quantity: int.parse(this.quantityController.text),
                          );

                          await invoiceController.createInvoice(invoice);

                          await invoiceController.getInvoices();

                          Get.offAll(Home());

                          BannerUtils.showBanner(
                              'Feito!', 'Venda gerada com sucesso!');
                        },
                        title: 'Salvar',
                      ),
                    ),
                  }
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
