import 'package:badges/badges.dart';
import 'package:ecommerce_app/src/services/extensions.dart';

import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:provider/provider.dart';

import '../config/themes/colors.dart';
import '../provider/cart_provider.dart';

Widget _icon(BuildContext context, IconData icon,
    {Color color = AppColor.black}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Icon(
      icon,
      color: color,
      size: 27,
    ),
  );
}

SliverAppBar customAppBar(
  BuildContext context, {
  String? title,
  String? leadingMethod,
  String? actionMethod,
  VoidCallback? leadingOnPressed,
  GestureTapCallback? actionOnTap,
  bool leading = true,
  bool action = true,
}) {
  _leading({required leadingMethod}) {
    if (leadingMethod == 'back' && leading == true) {
      return _icon(context, Icons.arrow_back).onTap(leadingOnPressed!);
    }
    if (leadingMethod == 'listView' && leading == true) {
      return _icon(context, Icons.format_list_bulleted)
          .onTap(leadingOnPressed!);
    }
    if (leadingMethod == 'gridView' && leading == true) {
      return _icon(context, Icons.grid_view).onTap(leadingOnPressed!);
    }
    if (leading == false) return Container();
  }

  _action({required actionMethod}) {
    if (actionMethod == 'user' && action == true) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Image.asset("images/customer_login_avatar.png")
                .onTap(actionOnTap!),
          ),
        )
      ];
    }
    if (actionMethod == 'shopCart' && action == true) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              position: BadgePosition.topEnd(top: 3, end: 2),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                cart.productsCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
              showBadge: cart.basketProducts.isEmpty ? false : true,
              child: _icon(context, IcoFontIcons.uiCart).onTap(actionOnTap!),
            ),
          ),
        )
      ];
    }
    if (action == false) return [Container()];
  }

  return SliverAppBar(
    elevation: 0.0,
    backgroundColor: AppColor.background,
    leading: _leading(leadingMethod: leadingMethod),
    actions: _action(actionMethod: actionMethod),
  );
}
