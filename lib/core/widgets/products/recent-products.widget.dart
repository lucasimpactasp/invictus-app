import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/screens/product/product.screen.dart';
import 'package:invictus/services/product/product.service.dart';
import 'package:invictus/utils/currency/currency.utils.dart';

class RecentProducts extends StatefulWidget {
  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  List<Product> products;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      loading = true;
    });
    final List productsResponse = await productService.getMany();

    setState(() {
      loading = false;
      products =
          productsResponse.map((product) => Product.fromJson(product)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(24),
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
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Itens adicionados recentemente',
              style: theme.textTheme.headline5,
            ),
          ),
          loading
              ? CircularProgressIndicator()
              : Row(
                  children: products
                      .sublist(0, products.length > 3 ? 3 : products.length)
                      .map((product) {
                    return Flexible(
                      child: GestureDetector(
                        onTap: () => Get.off(
                          ProductScreen(
                            id: product.id,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: products.last == product
                              ? EdgeInsets.zero
                              : EdgeInsets.only(right: 12),
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
                          child: Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 12, bottom: 6),
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(product.imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        product.id,
                                        style: theme.textTheme.caption,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Móvel',
                                      style: theme.textTheme.caption
                                          .copyWith(fontSize: 18),
                                    ),
                                    /* Text(
                                      product.name,
                                      style: theme.textTheme.headline6,
                                    ), */
                                    Text(
                                      'Quantidade: ${product.quantity.toString()}',
                                      style: theme.textTheme.headline6
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      CurrencyUtil.addCurrencyMask(
                                          product.price / 100),
                                      style: theme.textTheme.headline6
                                          .copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
