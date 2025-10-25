import 'package:flutter/material.dart';
import 'package:sipnudge/constants/color.dart';
import '../constants/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart'; // <-- for date formatting

/// 0 = Weekly, 1 = Monthly, 2 = Yearly
final ValueNotifier<int> selectedChartTab = ValueNotifier<int>(0);

class ChartTabBar extends StatefulWidget {
  const ChartTabBar({super.key});

  @override
  State<ChartTabBar> createState() => _ChartTabBarState();
}

class _ChartTabBarState extends State<ChartTabBar> {
  String getDateRange(int selectedIndex) {
    final now = DateTime.now();

    if (selectedIndex == 0) {
      // Weekly
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
      final endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday
      final start = DateFormat("MMM d").format(startOfWeek);
      final end = DateFormat("MMM d, yyyy").format(endOfWeek);
      return "$start - $end";
    } else if (selectedIndex == 1) {
      // Monthly
      final month = DateFormat("MMMM").format(now);
      final year = now.year;
      return "$month $year";
    } else {
      // Yearly
      return now.year.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColor.tabContainerColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: selectedChartTab,
            builder: (context, selectedIndex, _) {
              final dateRange = getDateRange(selectedIndex);
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.tabBarBgColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTabButton("Weekly", 0, selectedIndex == 0),
                        buildTabButton("Monthly", 1, selectedIndex == 1),
                        buildTabButton("Yearly", 2, selectedIndex == 2),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Assets.arrowLeft),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          dateRange,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Image.asset(Assets.arrowRight),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTabButton(String text, int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        selectedChartTab.value = index; // update global tab
        setState(() {

        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9D4EDD) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? AppColor.tabBarBgColor
                : AppColor.unselectedTabFontColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
