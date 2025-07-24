// ignore_for_file: public_member_api_docs, sort_constructors_first
// содержит event, какую-то просьбу у блока

part of 'crypto_list_bloc.dart';

class CryptoListEvent {}

class LoadCryptoList extends CryptoListEvent {
  final Completer? completer;
  LoadCryptoList({this.completer});
}
