import 'package:sipnudge/widgets/tabbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'auto_layout.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  int? touchedIndex;
  final ScrollController _scrollController = ScrollController();

  List<double> barHeights = [];

  @override
  void initState() {
    super.initState();
    selectedChartTab.addListener(_onTabChange);
    _generateBarHeightsForCurrentTab(); // initialize heights
  }

  @override
  void dispose() {
    selectedChartTab.removeListener(_onTabChange);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChange() {
    _generateBarHeightsForCurrentTab();
    setState(() {});
  }

  void _generateBarHeightsForCurrentTab() {
    final tabIndex = selectedChartTab.value;
    if (tabIndex == 0) {
      // Weekly
      barHeights = _generateRandomHeights(7);
    } else if (tabIndex == 1) {
      // Monthly
      barHeights = [90, 70, 100, 70, 90, 100, 60];
    } else {
      // Yearly
      barHeights = _generateRandomHeights(12);
    }
  }

  List<double> _generateRandomHeights(int count) {
    final random = Random();
    return List.generate(count, (_) => 50 + random.nextInt(50).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = selectedChartTab.value;

    // 📊 Data per tab
    List<String> xLabels;
    if (tabIndex == 0) {
      xLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    } else if (tabIndex == 1) {
      xLabels = ["16", "17", "18", "19", "20", "21", "22"];
    } else {
      xLabels = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
      ];
    }

    const yLabels = ["0", "20", "40", "60", "80", "100"];

    // 🧭 Bar dimensions
    const double barWidth = 36;
    const double barSpacing = 24;

    final double chartWidth =
        (barWidth + barSpacing) * barHeights.length + barSpacing;

    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Drink Completion",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            AutoLayoutHorizontal(),
          ]),

          // 🟣 Scrollable chart
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 🔹 Fixed Y-axis
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('100', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('80', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('60', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('40', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('20', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('0', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 8), // spacing between labels and chart

                // 🔹 Scrollable chart
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: chartWidth,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          BarChart(
                            BarChartData(
                              maxY: 100,
                              minY: 0,
                              borderData: FlBorderData(show: false),
                              gridData: const FlGridData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, _) {
                                      if (value.toInt() >= 0 && value.toInt() < xLabels.length) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Text(
                                            xLabels[value.toInt()],
                                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              ),
                              barTouchData: BarTouchData(
                                enabled: true,
                                handleBuiltInTouches: false,
                                touchCallback: (event, response) {
                                  if (response != null &&
                                      response.spot != null &&
                                      event.isInterestedForInteractions) {
                                    setState(() {
                                      touchedIndex = response.spot!.touchedBarGroupIndex;
                                    });
                                  } else {
                                    setState(() => touchedIndex = null);
                                  }
                                },
                              ),
                              barGroups: List.generate(barHeights.length, (i) {
                                final isTouched = i == touchedIndex;
                                final barColor = isTouched
                                    ? const Color(0xFFA22EFF)
                                    : const Color(0xFF6C00C3).withOpacity(0.48);
                                return BarChartGroupData(
                                  x: i,
                                  barsSpace: barSpacing,
                                  barRods: [
                                    BarChartRodData(
                                      toY: barHeights[i],
                                      width: barWidth,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [barColor, barColor],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),

                          // 💧 Bubble overlay
                          if (touchedIndex != null && touchedIndex! < barHeights.length)
                            Positioned(
                              left: barSpacing / 2 + touchedIndex! * (barWidth + barSpacing),
                              bottom: barHeights[touchedIndex!] + 90,
                              child: RaindropOverlay(
                                text: "${barHeights[touchedIndex!].toInt()}%",
                                borderColor: const Color(0xFFA22EFF),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}




class RaindropOverlay extends StatelessWidget {
  final String text;
  final Color borderColor;

  const RaindropOverlay({super.key, required this.text, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 52,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Teardrop shape with border
          ClipPath(
            clipper: _TeardropClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: borderColor,
              ),
            ),
          ),
          // Inner white circle
          Positioned(
            top: 4,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                maxLines: 1,
                style: const TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 12,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeardropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final radius = w / 2;

    Path path = Path();
    // Circle top
    path.addOval(Rect.fromCircle(center: Offset(w / 2, radius), radius: radius));
    // Triangle tip
    path.moveTo(w / 2, h);
    path.lineTo(0, radius + radius * 0.5);
    path.lineTo(w, radius + radius * 0.5);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


