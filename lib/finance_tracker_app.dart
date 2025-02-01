import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigator.dart';
import 'app_theme.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/register/register_bloc.dart';
import 'blocs/transaction/transaction_bloc.dart';
import 'blocs/transaction/transaction_event.dart';
import 'blocs/user/user_bloc.dart';
import 'screens/add_expense_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/statistics_screen.dart';

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of(context),
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            authRepository: RepositoryProvider.of(context),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(
            authRepository: RepositoryProvider.of(context),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: RepositoryProvider.of(context),
          ),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(
            transactionRepository: RepositoryProvider.of(context),
          )..add(FetchTransaction()),
        ),
      ],
      child: MaterialApp(
        // initialRoute: OnboardingScreen.routeName,
        home: const AppNavigator(),
        theme: AppTheme.mainTheme(),
        routes: {
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          StatisticsScreen.routeName: (context) => const StatisticsScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          AddExpenseScreen.routeName: (context) => const AddExpenseScreen(),
        },
      ),
    );
  }
}
