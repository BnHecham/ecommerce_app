import 'package:ecommerce_app/src/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/route.dart';
import '../../provider/product_provider.dart';
import '../../widgets/page_layout.dart';
import '../../widgets/product_card.dart';
import '../user_pages/userScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}


class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductProvider>().getProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customAppBar(context,
              leadingMethod:
                  context.watch<ProductProvider>().listOrGrid == false
                      ? 'listView'
                      : 'gridView', leadingOnPressed: () {
            context.read<ProductProvider>().isClicked();
          }, actionMethod: 'user', actionOnTap: () {
                push(const UserScreen());
              }),
        ],
        body: buildPage(context,
            child: context.watch<ProductProvider>().listOrGrid == false
                ? buildGridView()
                : buildListView(),
            topText: 'Our',
            bottomText: 'Products'),
      ),
    );
  }

  Widget buildGridView() {
    return Consumer<ProductProvider>(
        builder: (context, product, child) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 15,
                crossAxisSpacing: 1),
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            itemCount: product.products.length,
            itemBuilder: (_, _index) => ProductCardGrid(
                  index: _index,
                )));
  }

  Widget buildListView() => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Consumer<ProductProvider>(
          builder: (context, product, child) => ListView.builder(
              itemCount: product.products.length,
              itemBuilder: (_, _index) {
                return ProductCardList(
                  index: _index,
                );
              }),
        ),
      );
}
