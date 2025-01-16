import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/auth_repository.dart';
import 'finance_tracker_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepository = AuthRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => authRepository),
      ],
      child: const FinanceTrackerApp(),
    ),
  );
}
