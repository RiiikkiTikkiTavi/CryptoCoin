// интерфейс, определяещий правила для CoinsRepository

import 'package:crypto_coins/repositories/crypto_coins/models/models.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinDetails(String currencyCode);
}
