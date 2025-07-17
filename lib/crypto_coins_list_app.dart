import 'package:crypto_coins/router/router.dart';
import 'package:crypto_coins/theme/theme.dart';
import 'package:flutter/material.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      routes: routes,
      //initialRoute: '/', // маршрут, с которого начинается запуск
    );
  }
}
