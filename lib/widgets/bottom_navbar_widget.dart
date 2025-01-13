import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/statistics_screen.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRouteName = ModalRoute.of(context)?.settings.name;

    return BottomAppBar(
      shape:
          const CircularNotchedRectangle(), // Add notch for floating action button

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconButtonBuilder(
            context,
            icon: Icons.home_outlined,
            routeName: HomeScreen.routeName,
            currentRoute: currentRouteName,
          ),
          iconButtonBuilder(
            context,
            icon: Icons.line_axis_rounded,
            routeName: StatisticsScreen.routeName,
            currentRoute: currentRouteName,
          ),
          if (currentRouteName == '/') const SizedBox(width: 40),
          iconButtonBuilder(
            context,
            icon: Icons.wallet_outlined,
            routeName: '#',
            currentRoute: currentRouteName,
          ),
          iconButtonBuilder(
            context,
            icon: Icons.account_circle_outlined,
            routeName: ProfileScreen.routeName,
            currentRoute: currentRouteName,
          ),
        ],
      ),
    );
  }

  IconButton iconButtonBuilder(
    BuildContext context, {
    required IconData icon,
    required String routeName,
    String? currentRoute,
  }) {
    return IconButton(
      color: currentRoute == routeName ? Theme.of(context).primaryColor : null,
      icon: Icon(
        icon,
      ),
      onPressed: () => Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, (route) => false),
    );
  }
}
