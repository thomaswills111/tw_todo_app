import 'package:flutter/material.dart';
import 'package:week_4/configs/constants.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: kBlue, inversePrimary: kRed),
  highlightColor: kRed,
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      toolbarHeight: 56,
      titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
  iconTheme: const IconThemeData(color: Colors.white),
  unselectedWidgetColor: Colors.white,
  useMaterial3: true,
);
