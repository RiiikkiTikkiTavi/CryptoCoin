import 'dart:async';
import 'package:crypto_coins/crypto_coins_list_app.dart';
import 'package:crypto_coins/firebase_options.dart';
import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // инициализация объекта talker для логирования
  final talker = TalkerFlutter.init();
  // регистрация в getIt
  GetIt.I.registerSingleton(talker);

  GetIt.I<Talker>().debug('Talker started');

  // имя бокса
  const cryptoCoinsBoxName = 'crypro_coins_box';
  // инициализация Hive
  await Hive.initFlutter();
  // говорим Hive, с какими адаптерами нужно работать
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  // открываем box c типом CryptoCoin
  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  talker.info(app.options.projectId);

  // логирование запросов http
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false),
    ),
  );

  // логирование событий bloc
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );
  // регистрация CryproCoinsRepository для использования только одного объекта
  // но много где
  // GetIt.instance.registerSingleton(CryproCoinsRepository(dio: Dio()));

  // LazySingleton создает объект при первом его упоминании
  // GetIt.I.registerLazySingleton(() => CryproCoinsRepository(dio: Dio()));

  // регистрация LazySingleton по типу AbstractCoinsRepository с реализацией CryproCoinsRepository
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryproCoinsRepository(dio: dio, cryptoCoinBox: cryptoCoinsBox),
  );

  // обработка ошибок интерфейса
  FlutterError.onError = (details) =>
      GetIt.I<Talker>().handle(details.exception, details.stack);

  // дополнительная обработка ошибок
  runZonedGuarded(() => runApp(const CryptoCurrenciesListApp()), (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
