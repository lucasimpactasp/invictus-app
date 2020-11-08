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

  final InvoiceController invoiceController = Get.put(InvoiceController());
  final ProductController productController = Get.put(ProductController());

  List<Installment> installments = [];
  List<String> products = [];

  Invoice invoice;
  bool showProducts = false;

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
                  invoice: invoice,
                  onUpdateParcels: (List<Installment> installmentsRes) {
                    setState(() => installments = installmentsRes);
                  },
                ),
                if (products != null &&
                    products.length > 0 &&
                    showProducts) ...{
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
                  child: InvictusButton(
                    onPressed: () async {
                      int discount = 0;

                      if (discountController.text.isNotEmpty) {
                        discount = CurrencyUtil.cleanCurrencyMask(
                            discountController.text);
                      }

                      this.installments.forEach((installment) {
                        installment.title = titleController.text;
                      });

                      if (widget.invoice != null) {
                        print('asdasdas');
                        final UpdateInvoice invoice = UpdateInvoice(
                          discount: discount,
                          title: titleController.text,
                          installments: this.installments,
                          products: this.products,
                        );

                        print(invoice.toJson());

                        await invoiceController.updateInvoice(
                          this.invoice.id,
                          invoice,
                        );
                      } else {
                        final CreateInvoice invoice = CreateInvoice(
                          discount: discount,
                          title: titleController.text,
                          installments: this.installments,
                          products: this.products,
                        );

                        await invoiceController.createInvoice(invoice);
                      }

                      // await invoiceController.getInvoices();

                      // Get.offAll(Home());

                      // BannerUtils.showBanner(
                      //     'Feito!', 'Venda gerada com sucesso!');
                    },
                    title: 'Salvar',
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
