import 'package:flutter/material.dart';

import '../transaction/transaction_widget.dart';

class StatisticsSpendWidget extends StatelessWidget {
  const StatisticsSpendWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Spending',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        TransactionWidget(),
      ],
    );
  }
}
