import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: Colors.black87,
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
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // обращение к общей теме
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Currencies List')),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, i) => ListTile(
          title: Text(
            'Bitcoin',
            style: theme.textTheme.bodyMedium,
          ), // применение стиля bodyMedium к тексту
          subtitle: Text('100000\$', style: theme.textTheme.labelSmall),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
