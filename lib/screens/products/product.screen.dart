import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/category/category.controller.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/controller/vendor/vendor.controller.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/models/vendor/vendor.model.dart';
import 'package:invictus/main.dart';
import 'package:invictus/screens/category/category-manager.screen.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';
import 'package:invictus/screens/vendor/vendor-manager.screen.dart';
import 'package:invictus/services/product/product.service.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'dart:io' show Platform;

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product product;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      setState(() => product = widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: InvictusApp.role == 'admin'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      await productService.deleteOne(widget.product.id);

                      Get.offAll(Home());
                    },
                    heroTag: null,
                    backgroundColor: theme.primaryColor,
                    child: Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    Get.to(
                      ProductManager(
                        product: widget.product,
                      ),
                    );
                  },
                  heroTag: null,
                  backgroundColor: theme.primaryColor,
                  child: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            )
          : null,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              constraints: BoxConstraints(maxWidth: 1200),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      image: product.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                product.imageUrl,
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: theme.primaryColor,
                    ),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Platform.isIOS
                            ? Icons.arrow_back_ios
                            : Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.id ?? '',
                              style: theme.textTheme.caption
                                  .copyWith(fontSize: 14),
                            ),
                            Text(
                              product.name ?? '',
                              style: theme.textTheme.headline5.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Quantidade: ${product.quantity?.toString() ?? ''}',
                              style: theme.textTheme.headline6.copyWith(
                                fontSize: 16,
                                color: theme.textTheme.bodyText2.color,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              CurrencyUtil.addCurrencyMask(
                                  widget.product.price ?? 0),
                              style: theme.textTheme.headline6.copyWith(
                                fontSize: 16,
                                color: theme.textTheme.bodyText2.color,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text('Dimensão: ${product.dimension ?? ''}'),
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
                  if (widget.product.category != null) ...{
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final CategoryController categoryController =
                                Get.put(CategoryController());

                            setState(() => loading = true);

                            final Category category = await categoryController
                                .getCategory(
                                  widget.product.category.id,
                                )
                                .catchError(
                                    (error) => setState(() => loading = false));

                            setState(() => loading = false);

                            Get.to(
                              CategoryManagerScreen(
                                category: category,
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: theme.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Text(
                              widget.product.category.name,
                              style: theme.textTheme.bodyText2.copyWith(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  },
                  if (widget.product.vendor != null) ...{
                    GestureDetector(
                      onTap: () async {
                        final VendorController vendorController =
                            Get.put(VendorController());
                        final ProductController productController =
                            Get.put(ProductController());

                        await productController.getMany();

                        final Vendor vendor = await vendorController
                            .getVendor(widget.product.vendor.id);

                        if (productController.products != null &&
                            productController.products.length > 0) {
                          Get.to(
                            VendorManagerScreen(
                              products: productController.products,
                              vendor: vendor,
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 6,
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                'Fornecedor',
                                style: theme.textTheme.headline6.copyWith(
                                  fontSize: 18,
                                  color: theme.textTheme.bodyText2.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(product.vendor.name ?? ''),
                            Text(product.vendor.email ?? ''),
                            Text(product.vendor.phone ?? ''),
                          ],
                        ),
                      ),
                    ),
                  },
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
                        Text(product.description ?? ''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
