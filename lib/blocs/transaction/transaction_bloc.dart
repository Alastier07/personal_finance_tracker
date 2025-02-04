import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/blocs/transaction/transaction_event.dart';
import 'package:personal_finance_tracker/blocs/transaction/transaction_state.dart';

import '../../data/model/transaction_model.dart';
import '../../data/repository/transcation_repository.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  List<TransactionModel> transactions = [];
  double _totalAmountOfIncome = 0.0;
  double _totalAmountOfExpenses = 0.0;

  double get totalAmountOfIncome => _totalAmountOfIncome;
  double get totalAmountOfExpenses => _totalAmountOfExpenses;

  TransactionBloc({required this.transactionRepository})
      : super(TransactionInitial()) {
    on<FetchTransaction>((event, emit) async {
      // Fetch transactions
      transactions =
          transactionRepository.getTransactions().cast<TransactionModel>();
      // Total amount of transactions
      _calculateTotalAmountOfTransaction();
      // Emit transactions
      emit(TransactionLoaded(transactions: List.from(transactions)));
    });

    on<AddTransaction>((event, emit) {
      // Add transaction
      transactions.add(event.transaction);
      // Cache transaction
      transactionRepository.saveTransactions(event.transaction);
      // Total amount of transactions
      _calculateTotalAmountOfTransaction();
      // Emit transactions
      emit(TransactionLoaded(transactions: List.from(transactions)));
    });
  }

  void _calculateTotalAmountOfTransaction() {
    _totalAmountOfExpenses = transactionRepository.getTotalTransactionAmount(
      transactions,
      TransactionType.expense,
    );

    _totalAmountOfIncome = transactionRepository.getTotalTransactionAmount(
      transactions,
      TransactionType.income,
    );
  }
}
