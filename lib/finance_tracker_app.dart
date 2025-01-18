import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigator.dart';
import 'app_theme.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/login/login_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/profile_screen.dart';
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
      ],
      child: MaterialApp(
        // initialRoute: OnboardingScreen.routeName,
        home: const AppNavigator(),
        theme: AppTheme.mainTheme(),
        routes: {
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          StatisticsScreen.routeName: (context) => const StatisticsScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
