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

  factory Futures.fromMap(Map<dynamic, dynamic> map) {
    return Futures(
      map["base"],
      map["qoute"],
      map["lastPrice"],
      map["volume"],
    );
  }
}
