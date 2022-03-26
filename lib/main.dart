import 'package:fashionstore/Providers/Cart.dart';
import 'package:fashionstore/Providers/products.dart';
import 'package:fashionstore/screens/cart_screen.dart';
import 'package:fashionstore/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          home: const HomeScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
          }),
    );
  }
}
