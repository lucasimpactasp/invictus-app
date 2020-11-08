import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/category/category.controller.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class CategoryManagerScreen extends StatefulWidget {
  final Category category;

  CategoryManagerScreen({this.category});

  @override
  _CategoryManagerScreenState createState() => _CategoryManagerScreenState();
}

class _CategoryManagerScreenState extends State<CategoryManagerScreen> {
  final TextEditingController nameController = TextEditingController();
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());

  List<String> products = [];

  @override
  void initState() {
    super.initState();

    init();
    loadForm();
  }

  void init() async {
    await productController.getMany();
  }

  void loadForm() {
    if (widget.category != null) {
      this.nameController.text = widget.category.name;

      if (widget.category.products != null) {
        setState(() =>
            this.products = widget.category.products.map((e) => e.id).toList());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = productController.products;
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: InvictusAppBar.getAppBar(),
        body: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome da categoria',
                    ),
                  ),
                  if (products != null && products.length > 0) ...{
                    Obx(
                      () => MultiSelectFormField(
                        autovalidate: false,
                        chipBackGroundColor: Colors.red,
                        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        checkBoxActiveColor: Colors.red,
                        checkBoxCheckColor: Colors.green,
                        dialogShapeBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
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
                    ),
                  },
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(24),
                    child: InvictusButton(
                      onPressed: () async {
                        final CategoryParams category = CategoryParams(
                          name: nameController.text,
                          products: this.products,
                        );

                        if (widget.category == null) {
                          await categoryController.createCategory(category);
                        } else {
                          await categoryController.updateCategory(
                            widget.category.id,
                            category,
                          );

                          print('askdjasld');
                        }
                        await productController.getMany();
                        Get.offAll(Home());

                        if (widget.category != null) {
                          BannerUtils.showBanner(
                              'Feito!', 'Categoria atualizada com sucesso!');
                        } else {
                          BannerUtils.showBanner(
                              'Feito!', 'Categoria criada com sucesso!');
                        }
                      },
                      title: widget.category != null ? 'Atualizar' : 'Salvar',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
