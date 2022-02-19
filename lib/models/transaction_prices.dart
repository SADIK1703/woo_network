abstract class TransactionPrices {
  final String base;
  final String qoute;
  final double lastPrice;
  final double volume;

  String get symbol;

  TransactionPrices({
    required this.base,
    required this.qoute,
    required this.lastPrice,
    required this.volume,
  });
}
