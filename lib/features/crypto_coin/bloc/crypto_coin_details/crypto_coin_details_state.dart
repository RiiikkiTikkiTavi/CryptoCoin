// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crypto_coin_details_bloc.dart';

class CryptoCoinDetailsState extends Equatable {
  const CryptoCoinDetailsState();

  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoaded extends CryptoCoinDetailsState {
  final CryptoCoin coin;
  const CryptoCoinDetailsLoaded({required this.coin});

  @override
  List<Object?> get props => [coin];
}

class CryptoCoinDetailsLoading extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoading();
}

class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailsState {
  final Object? exception;
  const CryptoCoinDetailsLoadingFailure(this.exception);

  @override
  List<Object?> get props => super.props..add(exception);
}
