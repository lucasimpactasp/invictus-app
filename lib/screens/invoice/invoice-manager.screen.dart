import 'package:flutter/material.dart';
import 'package:invictus/core/models/invoice/installment.model.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/services/invoice/invoice.service.dart';

class InvoiceManager extends StatefulWidget {
  @override
  _InvoiceManagerState createState() => _InvoiceManagerState();
}

class _InvoiceManagerState extends State<InvoiceManager> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      body: ListView(
        children: [
          Form(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                ),
                TextField(
                  controller: totalController,
                ),
                TextField(
                  controller: discountController,
                ),
                RaisedButton(
                  onPressed: () async {
                    final Invoice invoice = Invoice(
                      discount: int.parse(discountController.text),
                      installments: [
                        Installment(
                          title: titleController.text,
                          price: int.parse(totalController.text),
                        ),
                      ],
                    );

                    await invoiceService.postOne(invoice.toJson());
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
