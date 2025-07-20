import 'package:crypto_coins/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins/models/crypto_coin.dart';
import 'package:crypto_coins/repositories/crypto_coins/crypro_coins_repository.dart';
import 'package:flutter/material.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context); // обращение к общей теме
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Currencies List')),
      body: (_cryptoCoinsList == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: _cryptoCoinsList!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, i) {
                final coin =
                    _cryptoCoinsList![i]; // переменная для одной из валют
                return CryptoCoinTile(coin: coin);
              },
            ),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await CryproCoinsRepository().getCoinsList();
    setState(() {}); // обновляем экран
  }
}
