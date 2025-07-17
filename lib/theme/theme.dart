import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: Colors.yellow, // дефолтный цвет, если не задан другой
  dividerColor: Colors.white24, // цвет разделителя списка
  scaffoldBackgroundColor: Colors.black87, // цвет фона
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black54,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white30,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white24),
);
