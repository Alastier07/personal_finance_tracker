import 'package:flutter/material.dart';

import '../data/repository/user_repository.dart';
import '../widgets/bottom_navbar_widget.dart';
import '../widgets/transaction/transaction_history_widget.dart';
import '../widgets/wallet_info_widget.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final userName = UserRepository().userName;

    return Scaffold(
      appBar: AppBar(
        title: Text(userName.isEmpty ? "Hello there!" : userName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            WalletInfoWidget(),
            SizedBox(height: 20),
            TransactionHistoryWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddExpenseScreen.routeName),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
