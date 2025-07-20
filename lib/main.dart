import 'package:crypto_coins/crypto_coins_list_app.dart';
import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  // регистрация CryproCoinsRepository для использования только одного объекта
  // но много где
  // GetIt.instance.registerSingleton(CryproCoinsRepository(dio: Dio()));

  // LazySingleton создает объект при первом его упоминании
  GetIt.I.registerLazySingleton(() => CryproCoinsRepository(dio: Dio()));
  runApp(const CryptoCurrenciesListApp());
}
