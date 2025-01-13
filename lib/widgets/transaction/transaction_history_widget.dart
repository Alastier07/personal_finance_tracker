import 'package:flutter/material.dart';

import 'transaction_widget.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('See all'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (ctx, i) => const TransactionWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
