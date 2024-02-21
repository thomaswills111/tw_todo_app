import 'package:flutter/material.dart';
import 'package:week_4/configs/constants.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: kRed),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    toolbarHeight: 56,
    titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)
  ),

  textTheme: TextTheme(),

  iconTheme: IconThemeData(color: Colors.white),

  useMaterial3: true,
);
