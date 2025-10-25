import 'package:flutter/material.dart';
import 'dart:math' as math;

class HydrationCard extends StatelessWidget {
  const HydrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 200,
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: ShapeDecoration(
        color: const Color(0xFF6A576D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 5,
            offset: Offset(5, 5),
            spreadRadius: 0,
          )
        ],
      ),
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hydration Source",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: Circular progress
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(120, 120),
                          painter: DualProgressPainter(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "100%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Water Intake",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 40),

                  // Right: Legends
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LegendItem(color: Color(0xFF369FFF), label: "Water (80%)"),
                      SizedBox(height: 12),
                      LegendItem(color: Color(0xFF81CC72), label: "Food (20%)"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );

  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}

class DualProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 10;
    final rect = Offset.zero & size;

    final waterPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF88EC6F9), Color(0xFF104B80)],
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final foodPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF81CC72), Color(0xFF81CC72)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;


    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 1.25,     // starting angle (slightly rotated for balance)
      math.pi * 1.7,      // 85% of 2π ≈ 1.7π
      false,
      waterPaint,
    );

// Draw food arc (25%)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.75,     // starting angle
      math.pi * 0.5,      // 25% of 2π ≈ 0.5π
      false,
      foodPaint,
    );

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
