import 'package:ecommerce_app/src/model/product.dart';
import 'package:ecommerce_app/src/pages/shop_pages/cart_screen.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../config/route.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../widgets/buildSnakeBar.dart';
import '../../widgets/build_app_bar.dart';
import '../../widgets/build_text.dart';
import '../../widgets/page_layout.dart';
import 'main_page.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({Key? key, required this.index, required this.product})
      : super(key: key);
  final int index;
  final Products product;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatingButton(widget.product),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customAppBar(context, leadingMethod: 'back', actionMethod: 'shopCart',
              leadingOnPressed: () {
                Navigator.pop(context);
          }, actionOnTap: () {
            push(MyCartScreen(
              product: widget.product,
              index: widget.index,));
          }),
        ],
        body: buildPage(context,
            child: Container(),
            customTitle: true,
            customTitleWidget: product()),
      ),
    );
  }

  Widget _productImage({required int index}) {
    return Container(
        width: AppTheme.fullWidth(context),
        height: AppTheme.fullHeight(context) / 2,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.15), BlendMode.darken),
              image: NetworkImage(widget.product.avatar!),
              fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ));
  }

  Widget _productTitle({required int index}) {
    ProductProvider productProv = context.watch<ProductProvider>();
    IconData icon = productProv.products[widget.index].isLiked!
        ? Icons.favorite
        : Icons.favorite_border_outlined;
    Color color = productProv.products[widget.index].isLiked!
        ? Colors.red
        : Colors.black87;

    return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTheme.fixedText(
                text: widget.product.title!.toTitleCase(),
                maxLines: 3,
                textStyle: AppTheme.h1Style),
            const SizedBox(
              width: 20,
            ),
            Icon(
              icon,
              color: color,
            ).onTap(() {
              productProv.isLiked(widget.index);
            }),
          ],
        ));
  }

  Widget _stars() {
    return Row(
      children: const <Widget>[
        Icon(Icons.star, color: AppColor.yellowColor, size: 17),
        Icon(Icons.star, color: AppColor.yellowColor, size: 17),
        Icon(Icons.star, color: AppColor.yellowColor, size: 17),
        Icon(Icons.star, color: AppColor.yellowColor, size: 17),
        Icon(Icons.star_border, size: 17),
      ],
    );
  }

  Widget _description({required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleText(
          text: "description".toUpperCase(),
          fontSize: 14,
        ),
        const SizedBox(height: 3.0),
        Text(widget.product.description!.toCapitalized()),
      ],
    );
  }

  Widget _productDetail({required int index}) {
    return DraggableScrollableSheet(
      maxChildSize: .50,
      initialChildSize: .40,
      minChildSize: .40,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: AppColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(widget.product.name!.toCapitalized(),
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              titleText(
                                text: widget.product.price!.toString(),
                                fontSize: 25,
                              ),
                              titleText(
                                text: " ${widget.product.currency!}",
                                fontSize: 18,
                                color: AppColor.red,
                              ),
                            ],
                          ),
                          _stars(),
                        ],
                      ),
                    ],
                  ),
                ),
                _description(index: widget.index)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _floatingButton(Products product) {
    return Consumer2<ProductProvider, CartProvider>(
      builder: (context, product, cart, child) => FloatingActionButton(
        backgroundColor: AppColor.orange,
        child: Icon(Icons.add_shopping_cart,
            size: 28,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
        onPressed: () {
          if (cart.basketProducts.contains(widget.product)) cart.exist = true;
          if (cart.exist == false) {
            if (cart.basketProducts.contains(product.products[widget.index]) ==
                false) {
              cart.addProduct(widget.product);
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar(content: "Item added Successfully!"));
            }
          }
          if (cart.exist == true &&
              cart.basketProducts.contains(product.products[widget.index])) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar(content: "Item already added!"));
          }

          if (cart.exist == true &&
              cart.basketProducts.contains(product.products[widget.index]) ==
                  false) {
            cart.addProduct(widget.product);
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar(content: "Item added Successfully!"));
          }
        },
      ),
    );
  }

  Widget product() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _productTitle(index: widget.index),
            _productImage(index: widget.index),
          ],
        ),
        _productDetail(index: widget.index),
      ],
    );
  }
}
