import 'package:woo_network/models/transaction_prices.dart';

class Spot implements TransactionPrices {
  @override
  final String base;
  @override
  final String qoute;
  @override
  final double lastPrice;
  @override
  final double volume;

  String get symbol => base + '/' + qoute;

  Spot(
    this.base,
    this.qoute,
    this.lastPrice,
    this.volume,
  );

  factory Spot.fromMap(Map<dynamic, dynamic> map) {
    return Spot(
      map["base"],
      map["qoute"],
      map["lastPrice"],
      map["volume"],
    );
  }
}
