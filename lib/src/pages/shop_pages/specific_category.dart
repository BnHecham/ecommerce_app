// ignore_for_file: file_names

import 'package:ecommerce_app/src/config/route.dart';
import 'package:ecommerce_app/src/pages/user_pages/userScreen.dart';
import 'package:ecommerce_app/src/provider/cart_provider.dart';
import 'package:ecommerce_app/src/provider/category_provider.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/product_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../config/route.dart';
import '../../widgets/build_app_bar.dart';
import '../../widgets/page_layout.dart';
import 'item_details_screen.dart';

class SpecificCategory extends StatefulWidget {
  const SpecificCategory({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  _SpecificCategoryState createState() => _SpecificCategoryState();
}

class _SpecificCategoryState extends State<SpecificCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customAppBar(context, leadingMethod: 'back', leadingOnPressed: () {
            Navigator.pop(context);
          }, actionOnTap: () {
            push(const UserScreen());
          }),
        ],
        body: buildPage(context,
            child: buildGridView(),
            topText:
                '${context.read<CategoryProvider>().categories[widget.index!].name}',
            bottomText: 'Category'),
      ),
    );
  }

  Widget buildGridView() {
    return Consumer<CategoryProvider>(
        builder: (context, category, child) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 15,
                crossAxisSpacing: 1),
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            itemCount: category.products.length,
            itemBuilder: (_, _index) => productsByItsCategory(
                  index: _index,
                )));
  }

  Widget productsByItsCategory({required int index}) {
    CategoryProvider categoryProductProv = context.watch<CategoryProvider>();
    IconData icon = categoryProductProv.products[index].isLiked!
        ? Icons.favorite
        : Icons.favorite_border_outlined;
    Color color =
    categoryProductProv.products[index].isLiked! ? Colors.red : Colors.black87;

    return Consumer3<CategoryProvider, ProductProvider, CartProvider>(
      builder: (context, category, product, cart, child) => Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(category.products[index].avatar!),
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.15), BlendMode.darken),
                  height: 160,
                  fit: BoxFit.cover,
                ).onTap(() {
                  push(ItemDetailsScreen(
                    index: index,
                    product: category.products[index],
                  ),);
                }),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    icon,
                    color: color,
                  ).onTap(() {
                    category.isLiked(index);
                    if (category.products[index].isLiked!) {
                      context.read<WishlistProvider>().addProduct(category.products[index]);
                    } else {
                      context.read<WishlistProvider>().removeProduct(category.products[index]);
                    }
                  }),
                ),
              ],
            ),
            Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, bottom: 3.0, top: 4.0),
                    child: Text(
                      category.products[index].title!,
                      style:
                          AppTheme.subTitleStyle.copyWith(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Cost : ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                      TextSpan(
                        text: "${category.products[index].price} ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: AppColor.red),
                      ),
                      TextSpan(
                        text: category.products[index].currency,
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                    ])),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "In Stock : ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                      TextSpan(
                        text: "${category.products[index].inStock} ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                    ])),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
