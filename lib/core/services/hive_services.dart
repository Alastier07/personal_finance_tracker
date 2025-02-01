import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../data/model/transaction_model.dart';
import '../../data/model/transaction_type.g.dart';

class HiveService {
  FirebaseAuth? firebaseAuth;

  HiveService({this.firebaseAuth});

  Box? _box;

  Future<void> initHive() async {
    try {
      final directory = await path_provider.getApplicationDocumentsDirectory();
      Hive
        ..init(directory.path)
        ..registerAdapter(TransactionModelAdapter())
        ..registerAdapter(TransactionTypeAdapter());

      firebaseAuth ??= FirebaseAuth.instance;

      final user = firebaseAuth!.currentUser;

      if (user == null) return; // No user

      _box = await Hive.openBox(user.uid);
      print('box$_box');
    } catch (error) {
      print('Error initializing Hive: $error');
    }
  }

  Future<void> openBoxHive({required String userId}) async {
    try {
      _box = await Hive.openBox(userId);
    } catch (error) {
      print('Error open box hive: $error');
    }
  }

  List getAllValue() {
    if (_box == null || _box!.isEmpty) return [];

    return _box!.values.toList();
  }

  Future<void> saveData(String key, TransactionModel value) async {
    print('box$_box');
    await _box!.put(key, value);
  }
}
