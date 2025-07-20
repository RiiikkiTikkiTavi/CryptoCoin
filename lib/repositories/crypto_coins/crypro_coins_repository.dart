// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';

class CryproCoinsRepository implements AbstractCoinsRepository {
  // экземпляр Dio - клиент для взаимодействия с сетью
  final Dio dio;
  CryproCoinsRepository({required this.dio});

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    // метод get - запрос данных по url
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,CAG&tsyms=USD',
    );
    debugPrint(response.toString());

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    // приведение data к CryptoCoin
    // entries - список частей словаря
    // map - метод проходит по списку
    final cryptoCOinList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/' + imageUrl,
      );
    }).toList();
    return cryptoCOinList;
  }
}
