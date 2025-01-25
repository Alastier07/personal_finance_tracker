import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/auth_repository.dart';
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
  final userRepository = UserRepository(firebaseAuth);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => authRepository),
        RepositoryProvider(create: (_) => userRepository),
      ],
      child: const FinanceTrackerApp(),
    ),
  );
}
