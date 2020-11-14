import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/payment/invoice.controller.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/controller/user/user.controller.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/products/recent-products.widget.dart';
import 'package:invictus/core/widgets/responsive/responsive.widget.dart';
import 'package:invictus/core/widgets/sales/sales-chart.widget.dart';
import 'package:invictus/core/widgets/user/best-seller.widget.dart';
import 'package:invictus/screens/vendor/vendor-manager.screen.dart';
import 'package:line_chart/model/line-chart.model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final productController = Get.put(ProductController());
  final userController = Get.put(UserController());
  final invoiceController = Get.put(InvoiceController());

  User user;
  List<LineChartModel> itemsOfChart = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    setState(() => loading = true);

    await productController.getMany();
    final userRes = await userController.getBestSeller();
    setState(() => user = userRes);
    final List<Invoice> invoices = await invoiceController.getInvoices();
    this.generateChartData(invoices);

    setState(() => loading = false);
  }

  void generateChartData(List<Invoice> invoices) {
    this.itemsOfChart = invoices
        .map((invoice) => LineChartModel(
              amount: invoice.total.toDouble(),
              date: DateTime.now(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/logo_black.png'),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: ListTile(
                title: Text('Cadastrar Venda'),
                onTap: () {
                  Get.toNamed('/invoice-manager');
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Cadastrar Produto'),
              onTap: () {
                Get.toNamed('/product-manager');
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cadastrar Categoria'),
              onTap: () {
                Get.toNamed('/category-manager');
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cadastrar Fornecedor'),
              onTap: () {
                Get.to(
                  VendorManagerScreen(
                    products: productController.products,
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cadastrar Usuário'),
              onTap: () {
                Get.toNamed('/user-manager');
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => init(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ResponsiveLayout(
                mobile: MobileHome(
                  width: width,
                  loading: loading,
                  itemsOfChart: itemsOfChart,
                  user: user,
                ),
                desktop: DesktopHome(
                  width: width,
                  loading: loading,
                  itemsOfChart: itemsOfChart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopHome extends StatelessWidget {
  const DesktopHome({
    Key key,
    @required this.width,
    this.loading,
    this.itemsOfChart,
  }) : super(key: key);

  final double width;
  final bool loading;
  final List<LineChartModel> itemsOfChart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RaisedButton(
          onPressed: () => Get.toNamed('/product-manager'),
          child: Text('Criar Produto'),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SalesChart(
                  data: this.itemsOfChart,
                  width: width * 0.65 - 48,
                  height: 190,
                ),
              ),
              RecentProducts(
                loading: loading,
              )
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }
}

class MobileHome extends StatelessWidget {
  const MobileHome({
    Key key,
    @required this.width,
    this.loading,
    this.itemsOfChart,
    this.user,
  }) : super(key: key);

  final double width;
  final bool loading;
  final User user;
  final List<LineChartModel> itemsOfChart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: SalesChart(
            data: this.itemsOfChart,
            width: width - 56,
            height: 190,
          ),
        ),
        RecentProducts(
          loading: loading,
        ),
        BestSeller(
          user: user,
        ),
      ],
    );
  }
}
