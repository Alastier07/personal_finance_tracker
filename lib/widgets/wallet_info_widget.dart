import 'package:flutter/material.dart';

class WalletInfoWidget extends StatelessWidget {
  const WalletInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.visibility_outlined,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '\$2,548.00',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                amountCycleBuilder(
                  icon: Icons.arrow_circle_down_outlined,
                  title: 'Income',
                  amount: '1,840.00',
                ),
                amountCycleBuilder(
                  icon: Icons.arrow_circle_up_outlined,
                  title: 'Expenses',
                  amount: '284.00',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column amountCycleBuilder({
    required String title,
    String amount = '0',
    required IconData icon,
  }) =>
      Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '\$$amount',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      );
}
