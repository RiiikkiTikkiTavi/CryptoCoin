import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_detail.g.dart'; // g- генерируемый файл

// сообщает, что нужно сгенерировать ддо
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  @JsonKey(name: 'PRICE') // как поле выглядит в приходящем запросе
  final double priceInUSD;

  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';

  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @JsonKey(
    name: 'LASTUPDATE',
    toJson: _dateTimeToJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;

  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hour;

  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;

  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });

  /// Connect the generated function to the `fromJson`
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  /// Connect the generated function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  // метод класса, который преобразовывает данные для отправки на сервер:
  // из DateTime в int
  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;
  // метод класса, который преобразовывает данные для получения с сервера:
  // из милисекунд в DateTime
  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);

  @override
  List<Object> get props => [
    priceInUSD,
    imageUrl,
    toSymbol,
    lastUpdate,
    high24Hour,
    low24Hour,
  ];
}
