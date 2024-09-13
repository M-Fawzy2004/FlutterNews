// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:newsapp/splash_screen.dart';
import 'package:newsapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeAppProvider(),
      child: Consumer<ThemeAppProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData.copyWith(
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'font'),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
