import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart'; // Using GetX for navigation
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/screen/splash_screen.dart';

final mytheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.black,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Using GetMaterialApp for navigation
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      home: SplashScreen(),
    );
  }
}
