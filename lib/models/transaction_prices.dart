abstract class TransactionPrices {
  final String base;
  final String qoute;
  final double lastPrice;
  final double volume;

  TransactionPrices({
    required this.base,
    required this.qoute,
    required this.lastPrice,
    required this.volume,
  });
}
