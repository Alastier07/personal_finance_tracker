import 'package:flutter/material.dart';

class StatisticsPeriodWidget extends StatelessWidget {
  const StatisticsPeriodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.transparent,
      destinations: [
        periodBuilder(title: 'Day'),
        periodBuilder(title: 'Week'),
        periodBuilder(title: 'Month'),
        periodBuilder(title: 'Year'),
      ],
    );
  }

  Widget periodBuilder({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
