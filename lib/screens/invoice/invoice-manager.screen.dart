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
import 'package:invictus/core/widgets/payment/payment-parcels.widget.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class InvoiceManager extends StatefulWidget {
  @override
  _InvoiceManagerState createState() => _InvoiceManagerState();
}

class _InvoiceManagerState extends State<InvoiceManager> {
  final TextEditingController titleController = TextEditingController();
  final MoneyMaskedTextController discountController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final MoneyMaskedTextController totalController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');

  final InvoiceController invoiceController = Get.put(InvoiceController());
  final ProductController productController = Get.put(ProductController());

  List<Installment> installments = [];
  List<String> products = [];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Product> products = productController.products;

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      body: ListView(
        children: [
          Form(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: discountController,
                  decoration: InputDecoration(labelText: 'Desconto'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9.,]'),
                    ),
                  ],
                ),
                PaymentParcel(
                  valueController: totalController,
                  onUpdateParcels: (List<Installment> installments) {
                    setState(() => this.installments = installments);
                  },
                ),
                if (products != null && products.length > 0) ...{
                  MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: Colors.red,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.red,
                    checkBoxCheckColor: Colors.green,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Produtos",
                      style: TextStyle(fontSize: 16),
                    ),
                    dataSource:
                        products.map((e) => e.toJson(addId: true)).toList(),
                    textField: 'name',
                    valueField: 'id',
                    okButtonLabel: 'Adicionar',
                    cancelButtonLabel: 'Cancelar',
                    hintWidget: Text('Clique para selecionar'),
                    initialValue: this.products,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        this.products =
                            value.map<String>((v) => v.toString()).toList();
                      });
                    },
                  ),
                },
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: theme.primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      int discount = 0;

                      if (discountController.text.isNotEmpty) {
                        discount = CurrencyUtil.cleanCurrencyMask(
                            discountController.text);
                      }

                      this.installments.forEach((installment) {
                        installment.title = titleController.text;
                      });

                      final CreateInvoice invoice = CreateInvoice(
                        discount: discount,
                        installments: this.installments,
                        products: this.products,
                      );

                      print(invoice.toJson());

                      await invoiceController.createInvoice(invoice);
                      await invoiceController.getInvoices();

                      Get.offAll(Home());

                      BannerUtils.showBanner(
                          'Feito!', 'Venda gerada com sucesso!');
                    },
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Text(
                      'Cadastrar venda',
                      style: theme.textTheme.bodyText2.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
