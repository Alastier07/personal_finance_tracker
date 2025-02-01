import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/hive_services.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/transcation_repository.dart';
import 'data/repository/user_repository.dart';
import 'finance_tracker_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuth = FirebaseAuth.instance;
  final authRepository = AuthRepository(firebaseAuth);
  final userRepository = UserRepository(authFirebase: firebaseAuth);

  final hiveService = HiveService(firebaseAuth: firebaseAuth);
  await hiveService.initHive();
  final transactionRepository = TransactionRepository(hiveService: hiveService);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => authRepository),
        RepositoryProvider(create: (_) => userRepository),
        RepositoryProvider(create: (_) => transactionRepository),
      ],
      child: const FinanceTrackerApp(),
    ),
  );
}
