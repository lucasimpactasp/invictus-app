import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/vendor/vendor.controller.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/models/vendor/vendor.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class VendorManagerScreen extends StatefulWidget {
  final Vendor vendor;
  final List<Product> products;

  VendorManagerScreen({this.products, this.vendor});

  @override
  _VendorManagerScreenState createState() => _VendorManagerScreenState();
}

class _VendorManagerScreenState extends State<VendorManagerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final MaskedTextController phoneController =
      MaskedTextController(mask: '(00) 00000-0000');
  final VendorController vendorController = Get.put(VendorController());

  List<String> products = [];

  @override
  void initState() {
    super.initState();

    loadForm();
  }

  void loadForm() {
    if (widget.vendor != null) {
      this.nameController.text = widget.vendor.name;
      this.emailController.text = widget.vendor.email;
      this.phoneController.updateText(widget.vendor.phone);

      if (widget.vendor.products != null) {
        setState(
          () =>
              this.products = widget.vendor.products.map((e) => e.id).toList(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      labelText: 'Nome do fornecedor',
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                    ),
                  ),
                  if (products.length > 0) ...{
                    MultiSelectFormField(
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
                      dataSource: widget.products
                          .map((e) => e.toJson(addId: true))
                          .toList(),
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
                  } else ...{
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                          'Não há nenhum produto cadastrado para poder selecionar'),
                    ),
                  },
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(24),
                      child: InvictusButton(
                        onPressed: () async {
                          String phone = '';
                          String text = 'Fornecedor criado com sucesso!';

                          if (this.phoneController.text.isNotEmpty) {
                            phone = this
                                .phoneController
                                .text
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .replaceAll('-', '')
                                .replaceAll(' ', '');
                          }

                          final VendorParams vendorParams = VendorParams(
                            email: this.emailController.text,
                            name: this.nameController.text,
                            phone: phone,
                            products: this.products,
                          );

                          if (widget.vendor != null) {
                            await vendorController.updateVendor(
                              widget.vendor.id,
                              vendorParams,
                            );

                            text = 'Fornecedor alterado com sucesso!';
                          } else {
                            await vendorController.createVendor(vendorParams);
                          }

                          Get.offAll(Home());

                          BannerUtils.showBanner('Feito!', text);
                        },
                        title: widget.vendor != null
                            ? 'Editar fornecedor'
                            : 'Salvar fornecedor',
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
