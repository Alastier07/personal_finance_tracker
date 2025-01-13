import 'package:flutter/material.dart';

import '../widgets/bottom_navbar_widget.dart';
import '../widgets/statistics/statistics_chart_widget.dart';
import '../widgets/statistics/statistics_period_widget.dart';
import '../widgets/statistics/statistics_spend_widget.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  static const String routeName = '/statistics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            StatisticsPeriodWidget(),
            StatisticsChartWidget(),
            SizedBox(height: 60),
            StatisticsSpendWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
