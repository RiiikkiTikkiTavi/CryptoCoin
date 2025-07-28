import 'package:crypto_coins/router/router.dart';
import 'package:crypto_coins/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      routes: routes,
      // следит за тем, какие страницы открываются
      navigatorObservers: [
        // передаем инстанс толкера
        TalkerRouteObserver(GetIt.I<Talker>()),
      ],
      //initialRoute: '/', // маршрут, с которого начинается запуск
    );
  }
}
