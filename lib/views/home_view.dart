import 'package:figmatask/widgets/chartcard.dart';
import 'package:figmatask/widgets/navbar.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/tabbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 24,left: 24,right: 24),
        decoration: BoxDecoration(
          gradient: AppColor.scaffoldBgGradient,
        ),
        child: ListView(
          children: [
            // Tabs
            ChartTabBar(),

            const SizedBox(height: 30),

            // Drink Completion Chart
            ChartCard(),
            const SizedBox(height: 30),

            // Hydration Source
            _buildCard(
              title: "Hydration Source",
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 10,
                              backgroundColor:
                              Colors.white.withOpacity(0.1),
                              valueColor:
                              const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF4F46E5)),
                            ),
                          ),
                          const Text(
                            "100%\nWater Intake",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _LegendItem(color: Color(0xFF60A5FA), text: "Water (80%)"),
                          SizedBox(height: 8),
                          _LegendItem(color: Color(0xFF34D399), text: "Food (20%)"),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Navbar(),
    );
  }


  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
