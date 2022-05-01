// ignore_for_file: file_names

import 'package:ecommerce_app/src/model/product.dart';
import 'package:ecommerce_app/src/pages/shop_pages/main_page.dart';
import 'package:ecommerce_app/src/pages/user_pages/userScreen.dart';
import 'package:ecommerce_app/src/provider/product_provider.dart';
import 'package:ecommerce_app/src/provider/wishlist_provider.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import 'package:ecommerce_app/src/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:provider/provider.dart';
import '../../config/route.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/build_app_bar.dart';
import '../../widgets/build_text.dart';
import '../../widgets/page_layout.dart';
import 'item_details_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key, this.index, this.product}) : super(key: key);
  final int? index;
  final Products? product;

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
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
                _customTitle(topText: 'Wishlist', bottomText: '')),
      ),
    );
  }

  Container _customTitle({required String topText, required String bottomText}) {
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
              child: context.read<WishlistProvider>().favoriteProducts.isNotEmpty
                  ? const Icon(
                      IcoFontIcons.trash,
                      size: 28,
                      color: AppColor.red,
                    ).onTap(() {
                      context.read<WishlistProvider>().removeAllProduct();
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
      itemCount: context.read<WishlistProvider>().favoriteProducts.length,
      itemBuilder: (BuildContext context, int index) => _buildCard(index),
    );
  }

  Card _buildCard(int index) {
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
                                  .read<WishlistProvider>()
                                  .favoriteProducts[index]
                                  .avatar!),
                              fit: BoxFit.cover),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        )).onTap(() {
                      push(ItemDetailsScreen(
                        index: index,
                        product: context.read<WishlistProvider>().favoriteProducts[index]
                      ),);
                    }),
                  )),
              _buildDetails(index)
            ],
          ),
        ));
  }

  Widget _buildDetails(int index) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlist, child) => Expanded(
      flex: 2,
      child:  Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 25.0),
                  child: Text(
                    wishlist.favoriteProducts[index].name!,
                    style: AppTheme.titleStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    "${"Price : "} ${"${wishlist.favoriteProducts[index].price} "} ${wishlist.favoriteProducts[index].currency}",
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
                  wishlist.removeProduct(wishlist.favoriteProducts[index]);
                })),
          ],
        ),
      ),
    );
  }

  Widget _itemsScreenLayout() {
    return context.watch<WishlistProvider>().favoriteProducts.isNotEmpty
        ? Column(
            children: [
              Expanded(child: _buildItems())
            ]
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppTheme.fullWidth(context) * .80,
                  height: AppTheme.fullHeight(context) * .50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/heart_box.jpg'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Your Wishlist is ",
                    style: AppTheme.h1Style.copyWith(color: AppColor.black),
                  ),
                  TextSpan(
                    text: "EMPTY",
                    style: AppTheme.h1Style.copyWith(color: AppColor.red),
                  ),
                ])),
                FittedBox(
                  child: Text(
                      "Tap heart button to start saving your favourite items.",
                      style: AppTheme.subTitleStyle),
                ),
                const SizedBox(
                  height: 15,
                ),
                BuildButton(
                    width: 150,
                    color: AppColor.orange,
                    text: 'Add Now',
                    textColor: Colors.white,
                    onPressed: () {
                      push(MainPages(index: 0));
                    }),
              ],
            ),
          );
  }
}
