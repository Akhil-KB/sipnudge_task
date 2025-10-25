import 'package:sipnudge/widgets/chartcard.dart';
import 'package:sipnudge/widgets/hydration_card.dart';
import 'package:sipnudge/widgets/navbar.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/tabbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.symmetric(vertical: 18,horizontal: 0),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.50, -0.80),
                            end: Alignment(0.50, 1.00),
                            colors: [const Color(0xFFB586BE), const Color(0xFF131313)],
                          ),
                        ), child: ListView(
                        children: [
                          ChartTabBar(),

                          const SizedBox(height: 30),

                          // Drink Completion Chart
                          ChartCard(),
                          const SizedBox(height: 30),

                          // Hydration Source
                          HydrationCard(),
                          SizedBox(height: 18,),
                          Navbar()
                        ],
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }

}


