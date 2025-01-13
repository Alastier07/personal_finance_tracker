import "package:flutter/material.dart";

import "../app_theme.dart";
import "home_screen.dart";
import "login_screen.dart";

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Spend Smarter Save More',
              style: AppTheme.welcomeTxt(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName,
                  (routes) => false,
                ),
                child: const Text('Get Started'),
              ),
            ),
            const SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Have Account? '),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName),
                  child: Text(
                    'Log In',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
