import 'dart:async';

import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

// CryptoListBloc наследуется от Bloc, который имеет 2 дженерик-параметра
class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>(_load);
  }

  Future<void> _load(
    LoadCryptoList event,
    Emitter<CryptoListState> emit,
  ) async {
    // регистрация обработчика event, в данном случае LoadCryptoList
    // emit - метод, возвращает state обратно на UI
    try {
      // если нет загруженного списка
      if (state is! CryptoListLoaded) {
        // показывать экран загрузки
        emit(CryptoListLoading());
      }
      // обращаемся методу переданного объекта для загрузки валют
      final coinList = await coinsRepository.getCoinsList();
      print('Crypro list loading...');
      // когда валюты загрузились, мы можем выдать emit'ом CryptoListLoaded
      emit(CryptoListLoaded(coinList: coinList));
    } catch (e) {
      emit(CryptoListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  final AbstractCoinsRepository coinsRepository;
}
