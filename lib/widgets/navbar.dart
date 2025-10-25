import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {'icon': "assets/images/icons/home.png", 'label': 'Home'},
    {'icon': "assets/images/icons/analysis.png",'label': 'Analysis'},
    {'icon':"assets/images/icons/events.png", 'label': 'Goals'},
    {'icon': "assets/images/icons/settings.png",'label': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container( margin: EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFF2B2536),
        shape: RoundedRectangleBorder(
          side: BorderSide(
       width:  1,
            color: const Color(0xFFF9F9F9),
          ),
          borderRadius: BorderRadius.circular(90)
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x16FFFFFF),
            blurRadius: 30,
            offset: Offset(4, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_navItems.length, (index) {
          final item = _navItems[index];
          final bool isSelected = _currentIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => _currentIndex = index);
              // You can add navigation logic here if needed
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
         width: MediaQuery.of(context).size.width/4.8,
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: ShapeDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB182BA), Color(0xFF2D1B31)],
                )
                    : null,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: isSelected ? 1 : 0,
                    color: isSelected
                        ? const Color(0xFFF9F9F9)
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(48),
                ),
                shadows: isSelected
                    ? const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(4, 4),
                  )
                ]
                    : [],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(item["icon"],width: 24,height: 24,),

                  const SizedBox(height: 4),
                  Text(
                    item['label'],
                    style: TextStyle(
                      color:
                    Colors.white,
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight:
                      isSelected ? FontWeight.w400 : FontWeight.w300,
                      height: 1,
                    ),textAlign: TextAlign.center,
                    maxLines: 1,overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
