import 'package:flutter/material.dart';

abstract class Palette {
  final Color black;
  final Color grey;
  final Color appleGreenLight;
  final Color errorDark;

  const Palette({
    required this.black,
    required this.grey,
    required this.appleGreenLight,
    required this.errorDark,
  });

  static Palette current = LightPalette();
}

class LightPalette extends Palette {
  LightPalette()
      : super(
            black: const Color(0xFF000000),
            grey: const Color(0xFF434545),
            appleGreenLight: const Color(0xFFE4F353),
            errorDark: const Color(0xFFFF0000));
}
