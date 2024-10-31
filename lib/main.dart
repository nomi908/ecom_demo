import 'package:ecommerce_demo/providers/addtocart_provider.dart';
import 'package:ecommerce_demo/providers/bottom_navbar_provider.dart';
import 'package:ecommerce_demo/providers/product_provider.dart';
import 'package:ecommerce_demo/screens/addtocart_screen.dart';
import 'package:ecommerce_demo/screens/product_main_screen.dart';
import 'package:ecommerce_demo/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (context) => AddToCartProvider()),
      ], child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Shopping',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
