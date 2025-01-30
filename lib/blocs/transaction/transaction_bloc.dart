import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/blocs/transaction/transaction_event.dart';
import 'package:personal_finance_tracker/blocs/transaction/transaction_state.dart';

import '../../data/model/transaction_model.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  List<TransactionModel> transactions = [];

  TransactionBloc() : super(TransactionInitial()) {
    on<FetchTransaction>((event, emit) {
      emit(TransactionLoaded(transactions: List.from(transactions)));
    });

    on<AddTransaction>((event, emit) {
      transactions.add(event.transaction);
      emit(TransactionLoaded(transactions: List.from(transactions)));
    });
  }
}
