import 'package:ecommerce_app/src/config/themes/theme.dart';
import 'package:ecommerce_app/src/pages/shop_pages/main_page.dart';
import 'package:ecommerce_app/src/pages/user_pages/welcome_screen.dart';
import 'package:ecommerce_app/src/provider/cart_provider.dart';
import 'package:ecommerce_app/src/provider/category_provider.dart';
import 'package:ecommerce_app/src/provider/login_provider.dart';
import 'package:ecommerce_app/src/provider/product_provider.dart';
import 'package:ecommerce_app/src/provider/register_provider.dart';
import 'package:ecommerce_app/src/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'Shop',
        navigatorKey: navigator,
        theme: AppTheme.themes.copyWith(
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}
