import 'package:figmatask/constants/color.dart';
import 'package:flutter/material.dart';

import '../constants/assets.dart';

class ChartTabBar extends StatefulWidget {
  const ChartTabBar({super.key});

  @override
  State<ChartTabBar> createState() => _ChartTabBarState();
}

class _ChartTabBarState extends State<ChartTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.tabContainerColor,
        borderRadius: BorderRadius.circular(15),
        border: BoxBorder.all(
          color: Colors.white.withOpacity(0.4)
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 17,vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.tabBarBgColor, // Matches the semi-transparent purple background
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTabButton("Weekly", true),
                buildTabButton("Monthly", false),
                buildTabButton("Yearly", false),
              ],
            ),
          ),
          const SizedBox(height: 8), // Space between tabs and date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(Assets.arrowLeft),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "Dec 16 - Dec 22, 2024",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Image.asset(Assets.arrowRight),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTabButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Add logic to handle tab selection if needed
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9D4EDD) : Colors.transparent, // Purple for selected tab
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColor.tabBarBgColor : AppColor.unselectedTabFontColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

