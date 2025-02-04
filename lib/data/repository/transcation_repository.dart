import '../../core/services/hive_services.dart';
import '../model/transaction_model.dart';

class TransactionRepository {
  final HiveService hiveService;

  TransactionRepository({required this.hiveService});

  // fetch
  List getTransactions() {
    return hiveService.getAllValue();
  }

  // save
  void saveTransactions(TransactionModel transaction) {
    hiveService.saveData(DateTime.now().toString(), transaction);
  }

  double getTotalTransactionAmount(
    List<TransactionModel> transactions,
    TransactionType type,
  ) {
    final newTransaction =
        transactions.where((trans) => trans.type == type).toList();

    return newTransaction.fold<double>(
      0.0, // initial value
      (sum, transaction) => sum + transaction.amount, // function: combine
    );
  }
}
