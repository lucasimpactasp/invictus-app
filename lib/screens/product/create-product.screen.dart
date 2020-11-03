import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/services/category/category.service.dart';
import 'package:invictus/services/product/product.service.dart';
import 'package:menu_button/menu_button.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  Category selectedItem;
  List<Category> items = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final List categoriesRes = await categoryService.getMany();
    if (categoriesRes != null) {
      setState(() {
        items = categoriesRes
            .map((category) => Category.fromJson(category))
            .toList();
        selectedItem = items[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final dynamic user = userController.user;

    final Widget button = SizedBox(
      width: 83,
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
                    ))),
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
              children: [
                MenuButton(
                  child: button, // Widget displayed as the button
                  items: items, // List of your items
                  topDivider: true,
                  popupHeight:
                      200, // This popupHeight is optional. The default height is the size of items
                  scrollPhysics:
                      AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                  itemBuilder: (value) => Container(
                    width: 83,
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
                  onMenuButtonToggle: (isToggle) {
                    print(isToggle);
                  },
                ),
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
                  inputFormatters: [
                    TextInputMask(
                      mask: 'R\$! !9+.999,99',
                      placeholder: '0',
                      maxPlaceHolders: 3,
                      reverse: true,
                    ),
                  ],
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
                RaisedButton(
                  onPressed: () async {
                    int price = 0;
                    int quantity = 0;

                    if (priceController.text.isNotEmpty) {
                      String textPrice = priceController.text
                          .replaceAll('\$', '')
                          .replaceAll(' ', '')
                          .replaceAll('.', '')
                          .replaceAll(',', '');

                      price = int.parse(textPrice);
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
                      category: selectedItem,
                      createdBy: user['id'],
                    );

                    await productService.postOne(product.toJson(product));
                    Get.snackbar('Feito!', 'Produto criado com sucesso.');
                  },
                  child: Text('Criar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
