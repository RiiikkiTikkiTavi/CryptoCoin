// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryproCoinsRepository implements AbstractCoinsRepository {
  // экземпляр Dio - клиент для взаимодействия с сетью
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinBox;

  CryproCoinsRepository({required this.cryptoCoinBox, required this.dio});

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinList = <CryptoCoin>[];
    try {
      cryptoCoinList = await _fetchCoinsLisFromApi();

      // преобразование в мапу, ключ - наименование валюты, значение - данные о валюте
      final cryptoCoinMap = {for (var e in cryptoCoinList) e.name: e};
      // запись в box мапы (ключ-значение)
      await cryptoCoinBox.putAll(cryptoCoinMap);
    } catch (e, st) {
      // если метод получения данные с api вернулся с ошибкой, берем из бд
      GetIt.I<Talker>().handle(
        e,
        st,
      ); // обработка ошибок, передаем ошибку наверх
      cryptoCoinList = cryptoCoinBox.values.toList();
    }
    cryptoCoinList.sort(
      (a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD),
    );
    return cryptoCoinList;
  }

  Future<List<CryptoCoin>> _fetchCoinsLisFromApi() async {
    // метод get - запрос данных по url
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,CAG&tsyms=USD',
    );
    //debugPrint(response.toString());

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    // приведение data к CryptoCoin
    // entries - список частей словаря
    // map - метод проходит по списку
    final cryptoCoinList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

      final details = CryptoCoinDetail.fromJson(usdData);

      // final price = usdData['PRICE'];
      // final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        details: details,
        // priceInUSD: price,
        // imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      );
    }).toList();

    return cryptoCoinList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return cryptoCoinBox.get(
        currencyCode,
      )!; // получить данные по ключу валюты
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoin(name: currencyCode, details: details);
  }
}
