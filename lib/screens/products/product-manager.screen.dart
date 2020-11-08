import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/controller/vendor/vendor.controller.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/models/vendor/vendor.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/services/category/category.service.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:menu_button/menu_button.dart';

class ProductManager extends StatefulWidget {
  final Product product;

  ProductManager({this.product});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  Category selectedItem;
  Vendor selectedVendor;
  List<Category> items = [];
  List<Vendor> vendors = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MoneyMaskedTextController priceController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  TextEditingController quantityController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    init();
    loadForm();
  }

  void init() async {
    final VendorController vendorController = Get.put(VendorController());

    final List<Category> categoriesRes = await categoryService.getMany();
    final List<Vendor> vendors = await vendorController.getVendors();

    if (categoriesRes != null && categoriesRes.length > 0) {
      setState(() {
        items = categoriesRes;
      });
    }

    if (vendors != null && vendors.length > 0) {
      setState(() {
        this.vendors = vendors;
      });
    }
  }

  void loadForm() {
    if (widget.product != null) {
      if (widget.product.name.isNotEmpty) {
        nameController.text = widget.product.name;
      }

      if (widget.product.description.isNotEmpty) {
        descriptionController.text = widget.product.description;
      }

      if (widget.product.price != null) {
        priceController.text = widget.product.price.toString();
      }

      if (widget.product.quantity != null) {
        quantityController.text = widget.product.quantity.toString();
      }

      if (widget.product.dimension.isNotEmpty) {
        dimensionController.text = widget.product.dimension;
      }

      if (widget.product.imageUrl.isNotEmpty) {
        imageController.text = widget.product.imageUrl;
      }

      if (widget.product.category != null) {
        setState(() => selectedItem = widget.product.category);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget button = SizedBox(
      width: 200,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                selectedItem?.name ?? '',
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final Widget vendorButton = SizedBox(
      width: 200,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                selectedVendor?.name ?? '',
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      body: ListView(
        children: [
          Text(
            'Criação de Produto',
            style: theme.textTheme.headline5,
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (this.items.length > 0) ...{
                  Text('Categoria'),
                  MenuButton(
                    child: button, // Widget displayed as the button
                    items: items, // List of your items
                    topDivider: true,
                    popupHeight:
                        200, // This popupHeight is optional. The default height is the size of items
                    scrollPhysics:
                        AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                    itemBuilder: (value) => Container(
                      width: 200,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(value.name),
                    ), // Widget displayed for each item
                    toggledChild: Container(
                      color: Colors.white,
                      child: button, // Widget displayed as the button,
                    ),
                    divider: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onItemSelected: (value) {
                      setState(() {
                        selectedItem = value;
                      });
                      // Action when new item is selected
                    },
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3.0)),
                        color: Colors.white),
                    onMenuButtonToggle: (isToggle) {},
                  ),
                } else ...{
                  Text('Não há nenhuma categoria cadastrada'),
                },
                if (this.vendors.length > 0) ...{
                  Text('Fornecedor'),
                  // Vendors
                  MenuButton(
                    child: vendorButton, // Widget displayed as the button
                    items: vendors, // List of your items
                    topDivider: true,
                    popupHeight:
                        200, // This popupHeight is optional. The default height is the size of items
                    scrollPhysics:
                        AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                    itemBuilder: (value) => Container(
                      width: 200,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(value.name),
                    ), // Widget displayed for each item
                    toggledChild: Container(
                      color: Colors.white,
                      child: vendorButton, // Widget displayed as the button,
                    ),
                    divider: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onItemSelected: (value) {
                      setState(() {
                        this.selectedVendor = value;
                      });
                      // Action when new item is selected
                    },
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3.0)),
                        color: Colors.white),
                    onMenuButtonToggle: (isToggle) {},
                  ),
                } else ...{
                  Text('Não há nenhum fornecedor cadastrado'),
                },
                TextField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  controller: nameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  controller: descriptionController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Preço'),
                  controller: priceController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Quantidade'),
                  controller: quantityController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Dimensão'),
                  controller: dimensionController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Imagem',
                  ), // TODO Trocar para outro modo (botão pra anexar imagem)
                  controller: imageController,
                ),
                InvictusButton(
                  onPressed: () async {
                    int price = 0;
                    int quantity = 0;

                    if (priceController.text.isNotEmpty) {
                      price =
                          CurrencyUtil.cleanCurrencyMask(priceController.text);
                    }

                    if (quantityController.text.isNotEmpty) {
                      quantity = int.parse(quantityController.text);
                    }

                    final Product product = Product(
                      name: nameController.text,
                      description: descriptionController.text,
                      price: price,
                      quantity: quantity,
                      dimension: dimensionController.text,
                      imageUrl: imageController.text,
                      category: selectedItem ?? Category(id: ''),
                      vendor: selectedVendor ?? Vendor(id: ''),
                    );

                    final ProductController productController = Get.put(
                      ProductController(),
                    );

                    if (widget.product == null) {
                      await productController.createProduct(product);
                      await productController.getMany();

                      BannerUtils.showBanner(
                        'Feito!',
                        'Produto criado com sucesso.',
                      );
                    } else {
                      await productController.updateOne(
                        widget.product.id,
                        product,
                      );
                      await productController.getMany();
                      BannerUtils.showBanner(
                        'Feito!',
                        'Produto alterado com sucesso.',
                      );
                    }

                    Get.offAllNamed('/home');
                  },
                  title: widget.product != null ? 'Atualizar' : 'Salvar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
