import 'package:flutter/material.dart';

import '../../core/constants/color.dart';
import '../../core/utils/date_time_utils.dart';
import '../../data/model/transaction_model.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (transaction.type == TransactionType.expense)
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: secondaryColor,
                  child: const Icon(Icons.shopping_bag_outlined),
                )
              else
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: secondaryColor,
                  child: const Icon(Icons.monetization_on_outlined),
                ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    defaultDateFormat(transaction.date),
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          Text(
            transaction.amount.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: transaction.type == TransactionType.expense
                  ? Colors.red
                  : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
