// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crypto_coins/repositories/crypto_coins/models/models.dart';

class CryptoCoinDetail extends CryptoCoin {
  final String toSymbol;
  final DateTime lastUpdate;
  final double high24Hour;
  final double low24Hour;
  const CryptoCoinDetail({
    required super.name,
    required super.priceInUSD,
    required super.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });

  @override
  List<Object> get props =>
      super.props..addAll([toSymbol, lastUpdate, high24Hour, low24Hour]);
}
