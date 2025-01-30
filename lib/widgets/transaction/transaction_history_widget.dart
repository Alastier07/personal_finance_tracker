import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/transaction/transaction_state.dart';
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
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoaded) {
                  final transactions = state.transactions;

                  return transactions.isEmpty
                      ? const Center(
                          child: Text('No transaction\'s yet!'),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (ctx, item) => TransactionWidget(
                            transaction: transactions[item],
                          ),
                        );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
