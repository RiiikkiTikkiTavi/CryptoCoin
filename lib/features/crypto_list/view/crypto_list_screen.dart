import 'package:crypto_coins/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  //List<CryptoCoin>? _cryptoCoinsList;

  // создаем переменную для обращения к объекту
  // по дженерику <CryproCoinsRepository> для bloc
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    //_loadCryptoCoins();
    // передача в bloc ивента, с помощью метода add
    // LoadCryptoList - event
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // обращение к общей теме
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Currencies List')),
      body: BlocBuilder<CryptoListBloc, CryptoListState>(
        // по какому блоку строить виджет
        bloc: _cryptoListBloc,
        builder: (context, state) {
          if (state is CryptoListLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: state.coinList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, i) {
                final coin = state.coinList[i]; // переменная для одной из валют
                return CryptoCoinTile(coin: coin);
              },
            );
          }
          if (state is CryptoListLoadingFailure) {
            return Center(
              child: Column(
                children: [
                  Text(
                    'Something went wrong',
                    style: theme.textTheme.headlineMedium,
                  ),
                  Text(
                    'Please try again later',
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),

      // (_cryptoCoinsList == null)
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         padding: const EdgeInsets.only(top: 16),
      //         itemCount: _cryptoCoinsList!.length,
      //         separatorBuilder: (context, index) => const Divider(),
      //         itemBuilder: (context, i) {
      //           final coin =
      //               _cryptoCoinsList![i]; // переменная для одной из валют
      //           return CryptoCoinTile(coin: coin);
      //         },
      //       ),
    );
  }

  // Future<void> _loadCryptoCoins() async {
  //   обращаемся к объекту по дженерику <CryproCoinsRepository>
  //   _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
  //  setState(() {}); // обновляем экран
  // }
}
