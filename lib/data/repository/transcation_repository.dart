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
}
