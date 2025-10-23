import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  int? touchedIndex;

  // Bar heights and labels
  final List<double> barHeights = [90, 70, 100, 70, 90, 100, 60];
  final List<String> xLabels = ["16", "17", "18", "19", "20", "21", "22"];
  final List<String> yLabels = ["0", "20", "40", "60", "80","100"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Drink Completion",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.7,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Bar chart
                BarChart(
                  BarChartData(
                    maxY: 100,
                    minY: 0,
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            if (yLabels.contains(value.toInt().toString())) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          interval: 20,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            if (value.toInt() >= 0 &&
                                value.toInt() < xLabels.length) {
                              return Text(
                                xLabels[value.toInt()],
                                style: const TextStyle(color: Colors.white70),
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
                        barRods: [
                          BarChartRodData(
                            toY: barHeights[i],
                            width: 36,
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

                // Overlay bubble
                if (touchedIndex != null)
                  Positioned(
                    left: 25.0 + touchedIndex! * 40,
                    bottom: barHeights[touchedIndex!] + 85, // close to bar
                    child: RaindropOverlay(
                      text: "${barHeights[touchedIndex!].toInt()}%",
                      borderColor: touchedIndex != null
                          ? const Color(0xFFA22EFF)
                          : Colors.transparent,
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
                  fontSize: 14,
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


