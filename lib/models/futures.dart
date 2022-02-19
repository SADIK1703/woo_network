import 'package:woo_network/models/transaction_prices.dart';

class Futures implements TransactionPrices {
  @override
  final String base;
  @override
  final String qoute;
  @override
  final double lastPrice;
  @override
  final double volume;

  String get symbol => base + '-' + qoute;

  Futures(
    this.base,
    this.qoute,
    this.lastPrice,
    this.volume,
  );

  factory Futures.fromMap(Map<String, dynamic> map) {
    return Futures(
      map["base"],
      map["quote"],
      map["lastPrice"].toDouble(),
      map["volume"].toDouble(),
    );
  }
}
