import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/notes.dart';

final mytheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 0, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
void main() {
  runApp(
    MaterialApp(
      theme: mytheme,
      home: Notes(),
    ),
  );
}
