import 'package:ecommerce_app/src/config/route.dart';
import 'package:ecommerce_app/src/model/product.dart';
import 'package:ecommerce_app/src/provider/cart_provider.dart';
import 'package:ecommerce_app/src/provider/product_provider.dart';
import 'package:ecommerce_app/src/provider/wishlist_provider.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/themes/colors.dart';
import '../config/themes/theme.dart';
import '../pages/shop_pages/item_details_screen.dart';
import 'buildSnakeBar.dart';

class ProductCardGrid extends StatefulWidget {
  const ProductCardGrid({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProductCardGrid> createState() => _ProductCardGridState();
}

class _ProductCardGridState extends State<ProductCardGrid> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProv = context.watch<ProductProvider>();
    IconData icon = productProv.products[widget.index].isLiked!
        ? Icons.favorite
        : Icons.favorite_border_outlined;
    Color color = productProv.products[widget.index].isLiked!
        ? Colors.red
        : Colors.black87;

    return Consumer<ProductProvider>(
      builder: (context, product, child) => Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Ink.image(
                  image: NetworkImage(product.products[widget.index].avatar!),onImageError: (_, __) =>
                              const Icon(Icons.error, size: 40),
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.15), BlendMode.darken),
                  height: 160,
                  fit: BoxFit.cover,
                ).onTap(() {
                  push(ItemDetailsScreen(
                    index: widget.index,
                    product: product.products[widget.index],
                  ),);
                }),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    icon,
                    color: color,
                  ).onTap(() {
                    product.isLiked(widget.index);
                    product.products[widget.index].isLiked!
                        ? context
                            .read<WishlistProvider>()
                            .addProduct(product.products[widget.index])
                        : context
                            .read<WishlistProvider>()
                            .removeProduct(product.products[widget.index]);
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
                      product.products[widget.index].title!,
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
                        text: "${product.products[widget.index].price} ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: AppColor.red),
                      ),
                      TextSpan(
                        text: product.products[widget.index].currency,
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
                        text: "${product.products[widget.index].inStock} ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                    ])),
                  ),
                ],
              ),
              Positioned(
                bottom: 2,
                right: 5,
                child: const Icon(Icons.add_shopping_cart).onTap(() {
                  CartProvider cart = context.read<CartProvider>();
                  for (Products _product in cart.basketProducts) {
                    cart.basketProducts.contains(_product)
                        ? cart.exist = true
                        : cart.exist = false;
                  }
                  if (cart.exist == false) {
                    if (cart.basketProducts
                            .contains(product.products[widget.index]) ==
                        false) {
                      cart.addProduct(product.products[widget.index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                          snackBar(content: "Item added Successfully!"));
                    }
                  }
                  if (cart.exist == true &&
                      cart.basketProducts
                          .contains(product.products[widget.index])) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar(content: "Item already added!"));
                  }

                  if (cart.exist == true &&
                      cart.basketProducts
                              .contains(product.products[widget.index]) ==
                          false) {
                    cart.addProduct(product.products[widget.index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                        snackBar(content: "Item added Successfully!"));
                  }
                }),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

//****************************************************************************************************************************//

class ProductCardList extends StatefulWidget {
  const ProductCardList({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProductCardList> createState() => _ProductCardListState();
}

class _ProductCardListState extends State<ProductCardList> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProv = context.read<ProductProvider>();
    IconData icon = productProv.products[widget.index].isLiked!
        ? Icons.favorite
        : Icons.favorite_border_outlined;
    Color color = productProv.products[widget.index].isLiked!
        ? Colors.red
        : Colors.black87;

    return Consumer2<CartProvider, ProductProvider>(
      builder: (context, cart, product, child) => Card(
          elevation: 2.0,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: AppTheme.padding.copyWith(left: 9.0, right: 9.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(children: [
              Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.15), BlendMode.darken),
                        image: NetworkImage(
                            product.products[widget.index].avatar!),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 140.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 30.0),
                      child: Text(
                        product.products[widget.index].name!,
                        style: AppTheme.titleStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 6.0,
                      ),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Cost : ",
                          style: AppTheme.subTitleStyle
                              .copyWith(color: Colors.black87),
                        ),
                        TextSpan(
                          text: "${product.products[widget.index].price} ",
                          style: AppTheme.subTitleStyle
                              .copyWith(color: AppColor.red),
                        ),
                        TextSpan(
                          text: product.products[widget.index].currency,
                          style: AppTheme.subTitleStyle
                              .copyWith(color: Colors.black87),
                        ),
                      ])),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "In Stock : ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                      TextSpan(
                        text: "${product.products[widget.index].inStock} ",
                        style: AppTheme.subTitleStyle
                            .copyWith(color: Colors.black87),
                      ),
                    ])),
                  ],
                ),
              ),
              Positioned(
                right: 5,
                bottom: 0,
                child: Row(
                  children: [
                    const Icon(Icons.add_shopping_cart).onTap(() {
                      if (cart.basketProducts
                          .contains(product.products[widget.index])) {
                        cart.exist = true;
                      }
                      if (cart.exist == false) {
                        if (cart.basketProducts
                                .contains(product.products[widget.index]) ==
                            false) {
                          cart.addProduct(product.products[widget.index]);
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar(content: "Item added Successfully!"));
                        }
                      }
                      if (cart.exist == true &&
                          cart.basketProducts
                              .contains(product.products[widget.index])) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBar(content: "Item already added!"));
                      }

                      if (cart.exist == true &&
                          cart.basketProducts
                                  .contains(product.products[widget.index]) ==
                              false) {
                        cart.addProduct(product.products[widget.index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBar(content: "Item added Successfully!"));
                      }
                    }),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      icon,
                      color: color,
                    ).onTap(() {
                      product.isLiked(widget.index);
                      product.products[widget.index].isLiked!
                          ? context
                              .read<WishlistProvider>()
                              .addProduct(product.products[widget.index])
                          : context
                              .read<WishlistProvider>()
                              .removeProduct(product.products[widget.index]);
                    }),
                  ],
                ),
              )
            ]),
          )),
    );
  }
}
