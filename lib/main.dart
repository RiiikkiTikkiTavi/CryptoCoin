import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const CryptoCurrenciesListApp());
}

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrenciesList',
      theme: ThemeData(
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
      ),
      routes: {
        '/': (context) => CryptoListScreen(),
        '/coin': (context) => CryptoCoinScreen(),
      },
      //initialRoute: '/', // маршрут, с которого начинается запуск
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // обращение к общей теме
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Currencies List')),
      body: ListView.separated(
        itemCount: 50,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          const coinName = 'Bitcoin';
          return ListTile(
            leading: SvgPicture.asset(
              'assets/svg/bitcoin.svg',
              height: 30,
              width: 30,
            ),
            title: Text(
              coinName,
              style: theme.textTheme.bodyMedium,
            ), // применение стиля bodyMedium к тексту
            subtitle: Text('100000\$', style: theme.textTheme.labelSmall),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/coin',
                arguments:
                    coinName, // передача параметра с этого экрана в /coin
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    // if (args == null) {
    //   log('You must provide args');
    //   return;
    // }
    // if (args is! String) {
    //   log('You must provide String arg');
    //   return;
    // }
    assert(
      args != null && args is String,
      'You must provide String args',
    ); // вызов ошибки при невыполнении условий
    coinName = args as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(coinName ?? '...')));
  }
}
