import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/widgets/products/recent-products.widget.dart';
import 'package:invictus/core/widgets/responsive/responsive.widget.dart';
import 'package:invictus/core/widgets/sales/sales-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final productController = Get.put(ProductController());

  bool loading = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    setState(() => loading = true);

    await productController.getMany().catchError((error) => print(error)); 

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Invictus App',
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => init(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ResponsiveLayout(
                mobile: MobileHome(width: width, loading: loading),
                desktop: DesktopHome(width: width, loading: loading),
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
  }) : super(key: key);

  final double width;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SalesChart(
                  data: [
                    LineChartModel(amount: 5000),
                    LineChartModel(amount: 6000),
                    LineChartModel(amount: 7000),
                    LineChartModel(amount: 1000),
                    LineChartModel(amount: 3500),
                    LineChartModel(amount: 2500),
                    LineChartModel(amount: 3000),
                    LineChartModel(amount: 8000),
                    LineChartModel(amount: 2000),
                    LineChartModel(amount: 1000),
                    LineChartModel(amount: 1500),
                    LineChartModel(amount: 4500),
                  ],
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
  }) : super(key: key);

  final double width;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: SalesChart(
            data: [
              LineChartModel(amount: 5000),
              LineChartModel(amount: 6000),
              LineChartModel(amount: 7000),
              LineChartModel(amount: 1000),
              LineChartModel(amount: 3500),
              LineChartModel(amount: 2500),
              LineChartModel(amount: 3000),
              LineChartModel(amount: 8000),
              LineChartModel(amount: 2000),
              LineChartModel(amount: 1000),
              LineChartModel(amount: 1500),
              LineChartModel(amount: 4500),
            ],
            width: width - 56,
            height: 190,
          ),
        ),
        RecentProducts(
          loading: loading,
        )
      ],
    );
  }
}
