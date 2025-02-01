import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/blocs/transaction/transaction_event.dart';
import 'package:personal_finance_tracker/blocs/transaction/transaction_state.dart';

import '../../data/model/transaction_model.dart';
import '../../data/repository/transcation_repository.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  List<TransactionModel> transactions = [];

  TransactionBloc({required this.transactionRepository})
      : super(TransactionInitial()) {
    on<FetchTransaction>((event, emit) {
      transactions =
          transactionRepository.getTransactions().cast<TransactionModel>();
      emit(TransactionLoaded(transactions: List.from(transactions)));
    });

    on<AddTransaction>((event, emit) {
      transactions.add(event.transaction);
      transactionRepository.saveTransactions(event.transaction);
      emit(TransactionLoaded(transactions: List.from(transactions)));
    });
  }
}
