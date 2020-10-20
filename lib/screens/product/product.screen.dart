import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'dart:io' show Platform;

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.primaryColor,
        child: Icon(
          Icons.edit,
        ),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 1200),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.id ?? '',
                        style: theme.textTheme.caption.copyWith(fontSize: 14),
                      ),
                      Text(
                        widget.product.name ?? '',
                        style: theme.textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Quantidade: ${widget.product.quantity?.toString() ?? ''}',
                        style: theme.textTheme.headline6.copyWith(
                          fontSize: 16,
                          color: theme.textTheme.bodyText2.color,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        CurrencyUtil.addCurrencyMask(widget.product.price ?? 0),
                        style: theme.textTheme.headline6.copyWith(
                          fontSize: 16,
                          color: theme.textTheme.bodyText2.color,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text('Dimensão: ${widget.product.dimension ?? ''}'),
                    ],
                  ),
                  Wrap(
                    children: [
                      //Container(child: ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 8,
                    offset: Offset.zero,
                    spreadRadius: .3,
                  ),
                ],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Observações',
                      style: theme.textTheme.headline6.copyWith(
                        fontSize: 18,
                        color: theme.textTheme.bodyText2.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(widget.product.description ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
