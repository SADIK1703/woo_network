import 'package:flutter/material.dart';
import 'package:woo_network/models/transaction_prices.dart';

class TransactionPriceLabel extends StatelessWidget {
  const TransactionPriceLabel({Key? key, required this.transactionPrice}) : super(key: key);
  final TransactionPrices transactionPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            transactionPrice.symbol,
            style: const TextStyle(color: Colors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transactionPrice.lastPrice.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                transactionPrice.volume.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
