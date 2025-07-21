// ignore_for_file: public_member_api_docs, sort_constructors_first
// описывает, что с блоком случилось
// отвечает за отображение на экране

part of 'crypto_list_bloc.dart';

class CryptoListState {}

class CryptoListInitial extends CryptoListState {}

class CryptoListLoading extends CryptoListState {}

// вызывается, когда экран с криптой готов, валюты загрузились
class CryptoListLoaded extends CryptoListState {
  final List<CryptoCoin> coinList;
  CryptoListLoaded({required this.coinList});
}

// вызывается, когда возникает ошибка
class CryptoListLoadingFailure extends CryptoListState {
  final Object? exception;
  CryptoListLoadingFailure({this.exception});
}
