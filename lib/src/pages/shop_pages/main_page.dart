// ignore_for_file: must_be_immutable

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecommerce_app/src/pages/shop_pages/wishlist_screen.dart';
import '../../config/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/product.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'products_screen.dart';

class MainPages extends StatefulWidget {
  MainPages({Key? key, this.index, this.product}) : super(key: key);
  int? index;
  final Products? product;

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigation(),
      body: buildPages(),
    );
  }

  Widget buildPages() {
    widget.index = i;
    switch (widget.index) {
      case 1:
        return const CategoriesScreen();
      case 2:
        return WishListScreen(
          product: widget.product,
          index: widget.index,
        );
      case 3:
        return MyCartScreen(
          product: widget.product,
          index: widget.index,
        );
      case 0:
      default:
        return const HomePageScreen();
    }
  }

  Widget buildBottomNavigation() {
    const MaterialColor _inactiveColor = Colors.grey;
    Color _activeColor = AppColor.orange;
    return BottomNavyBar(
      containerHeight: 55,
      showElevation: true,
      backgroundColor: Colors.white,
      selectedIndex: i,
      onItemSelected: (index) {
        setState(() => i = index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.store),
          title: const Text('Store'),
          textAlign: TextAlign.center,
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.cubesStacked),
          title: const Text('Categories'),
          textAlign: TextAlign.center,
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.solidHeart),
          title: const Text('Wishlist'),
          textAlign: TextAlign.center,
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.bagShopping),
          title: const Text('My Cart'),
          textAlign: TextAlign.center,
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }
}
