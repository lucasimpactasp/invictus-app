import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/payment/invoice.controller.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/screens/invoice/invoice-manager.screen.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:invictus/utils/debounce/debounce.util.dart';

class InvoicesScreen extends StatefulWidget {
  @override
  _InvoicesScreenState createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final InvoiceController invoiceController = Get.put(InvoiceController());
  final TextEditingController searchController = TextEditingController();
  final Debounce debounce = Debounce(Duration(milliseconds: 500));

  @override
  void initState() {
    invoiceController.getInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed('/product-manager');
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Vendas',
                      style: theme.textTheme.headline5,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Digite o nome da venda',
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey[200],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              BorderSide(color: Colors.grey[200], width: 1),
                        ),
                      ),
                      onChanged: (String term) {
                        debounce.run(() async {
                          return await invoiceController
                              .searchInvoicesByTitle(term);
                        }).onCancel(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: invoiceController.invoices == null
                      ? []
                      : invoiceController.invoices.map(
                          (invoice) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  InvoiceManager(
                                    invoice: invoice,
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                                margin:
                                    invoiceController.invoices.last == invoice
                                        ? EdgeInsets.symmetric(horizontal: 24)
                                        : EdgeInsets.all(24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          invoice.title ?? '',
                                          style: theme.textTheme.headline6,
                                        ),
                                        Text(
                                          CurrencyUtil.addCurrencyMask(
                                            invoice.total / 100,
                                          ),
                                          style: theme.textTheme.bodyText2
                                              .copyWith(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          '#${invoice.id.substring(0, 8)}',
                                          style: theme.textTheme.caption,
                                        )
                                      ],
                                    ),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      color: theme.primaryColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
