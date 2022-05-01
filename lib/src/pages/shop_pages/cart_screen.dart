// ignore_for_file: file_names, must_be_immutable

import 'package:ecommerce_app/src/model/product.dart';
import 'package:ecommerce_app/src/pages/shop_pages/main_page.dart';
import 'package:ecommerce_app/src/pages/user_pages/userScreen.dart';
import 'package:ecommerce_app/src/provider/product_provider.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import 'package:ecommerce_app/src/widgets/build_button.dart';
import '../../config/route.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:provider/provider.dart';

import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/build_app_bar.dart';
import '../../widgets/build_text.dart';
import '../../widgets/page_layout.dart';
import 'item_details_screen.dart';

class MyCartScreen extends StatefulWidget {
  MyCartScreen({Key? key, this.index, this.product}) : super(key: key);
  int? index;
  Products? product;

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customAppBar(context,
              leadingMethod: 'back',
              leadingOnPressed: () {
                push(MainPages(index: 0,));
              },
              actionMethod: 'user',
              actionOnTap: () {
                push(const UserScreen());

              }),
        ],
        body: buildPage(context,
            child: _itemsScreenLayout(),
            customTitle: true,
            customTitleWidget:
                _customTitle(topText: 'Shopping', bottomText: 'Cart')),
      ),
    );
  }

  Widget _customTitle({required String topText, required String bottomText}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: AppTheme.padding,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleText(
                text: topText,
                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),
              titleText(
                text: bottomText,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          //const SizedBox(width: 20,),
          Positioned(
              right: 0,
              top: 15,
              child: context.read<CartProvider>().basketProducts.isNotEmpty
                  ? Icon(
                      IcoFontIcons.trash,
                      size: 28,
                      color: AppColor.red.withOpacity(.80),
                    ).onTap(() {
                      context.read<CartProvider>().removeAllProduct();
                    })
                  : Container()),
        ],
      ),
    );
  }

  Widget _buildItems() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: context.read<CartProvider>().productsCount,
      itemBuilder: (BuildContext context, int index) => _buildCard(index),
    );
  }

  Widget _buildCard(int index) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(2.0),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.10),
                                  BlendMode.darken),
                              image: NetworkImage(context
                                  .read<CartProvider>()
                                  .basketProducts[index]
                                  .avatar!),
                              fit: BoxFit.cover),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        )).onTap(() {
                      push(ItemDetailsScreen(
                        index: index,
                        product: context.read<ProductProvider>().products[index],
                      ));
                    }),
                  )),
              _buildDetails(index)
            ],
          ),
        ));
  }

  Widget _buildDetails(int index) {
    return Expanded(
      flex: 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 25.0),
                child: Text(
                  context.read<CartProvider>().basketProducts[index].name!,
                  style: AppTheme.titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "${"Price : "} ${"${context.read<CartProvider>().basketProducts[index].price} "} ${context.read<CartProvider>().basketProducts[index].currency}",
                  style: AppTheme.subTitleStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "${"Subtotal : "} ${"${context.watch<CartProvider>().basketProducts[index].quantity == 1 ? context.read<CartProvider>().basketProducts[index].price : context.read<CartProvider>().basketProducts[index].price! * context.read<CartProvider>().basketProducts[index].quantity} "} ${context.read<CartProvider>().basketProducts[index].currency}",
                  style: AppTheme.subTitleStyle,
                ),
              ),
            ],
          ),
          Positioned(
              right: 5,
              top: 0,
              child: Icon(
                IcoFontIcons.closeCircled,
                color: AppColor.red.withOpacity(.85),
              ).onTap(() {
                context.read<CartProvider>().removeProduct(
                    context.read<CartProvider>().basketProducts[index]);
              })),
          _customToggleButton(index),
        ],
      ),
    );
  }

  Widget _customToggleButton(int index) {
    return Positioned(
      bottom: 0,
      right: 5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: AppColor.orange)
            //color: AppColor.orange
            ),
        child: RichText(
            text: TextSpan(children: [
          WidgetSpan(
              child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    IcoFontIcons.plus,
                    color: AppColor.orange,
                    size: 15,
                  )).onTap(() {
                context.read<CartProvider>().setQuantity(
                    isIncrement: true,
                    index: index,
                    product:
                        context.read<CartProvider>().basketProducts[index]);
              }),
              alignment: PlaceholderAlignment.middle),
          WidgetSpan(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey))),
            child: Text(
                context
                    .watch<CartProvider>()
                    .basketProducts[index]
                    .quantity
                    .toString(),
                style: AppTheme.titleStyle
                    .copyWith(color: AppColor.orange, fontSize: 15)),
          )),
          WidgetSpan(
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child:
                    Icon(IcoFontIcons.minus, color: AppColor.orange, size: 15),
              ).onTap(() {
                context.read<CartProvider>().setQuantity(
                    isIncrement: false,
                    index: index,
                    product:
                        context.read<CartProvider>().basketProducts[index]);
              }),
              alignment: PlaceholderAlignment.middle),
        ])),
      ),
    );
  }

  Widget _itemsScreenLayout() {
    return context.watch<CartProvider>().basketProducts.isNotEmpty
        ? Column(
            children: [
              Expanded(child: _buildItems()),
              _checkOut(widget.index!)
            ],
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppTheme.fullWidth(context),
                  height: AppTheme.fullHeight(context) / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/clear_cart.png'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Your cart is ",
                    style: AppTheme.h1Style.copyWith(color: AppColor.black),
                  ),
                  TextSpan(
                    text: "EMPTY",
                    style: AppTheme.h1Style.copyWith(color: AppColor.red),
                  ),
                ])),
                FittedBox(
                  child: Text(
                    "You have no items in your shopping cart.",
                    style: AppTheme.subTitleStyle.copyWith(fontSize: 16),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "Lets go buy something!",
                    style: AppTheme.subTitleStyle.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BuildButton(
                    width: 150,
                    color: AppColor.orange,
                    text: 'Shop Now',
                    textColor: Colors.white,
                    onPressed: () {
                      push(MainPages(index: 0,));
                    }),
              ],
            ),
          );
  }

  Widget _checkOut(int index) {
    return Container(
      padding: AppTheme.padding.copyWith(bottom: 0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 0),
              blurRadius: 10.0,
              spreadRadius: 1.50,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 0, right: 5.0, left: 5.0, top: 5.0),
            child: Consumer<CartProvider>(
              builder: (context, cart, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Checkout Price : ",
                    style: AppTheme.titleStyle,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "${cart.totalAmount} ",
                      style: AppTheme.titleStyle.copyWith(color: AppColor.red),
                    ),
                    TextSpan(
                      text: context
                          .read<ProductProvider>()
                          .products[index]
                          .currency,
                      style: AppTheme.titleStyle,
                    ),
                  ])),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Checkout",
                style: AppTheme.h1Style,
              ).onTap(() {})),
        ],
      ),
    );
  }
}
