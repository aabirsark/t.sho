import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:t_sho/app/constants.dart';
import 'package:t_sho/app/extensions/cntx.ext.dart';
import 'package:t_sho/app/extensions/navi.ext.dart';
import 'package:t_sho/meta/home.page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: Arc(context.responsive(800), context.responsive(1000),
                Colors.black26),
          ),
          const OnboardingHeader(),
          const OboardingBody(),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(milliseconds: 1500),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CustomPaint(
                painter: Arc(context.responsive(200), context.responsive(330),
                    buttonColor),
              ),
            ),
          ),
          Positioned(
            bottom: context.responsive(25),
            right: 5,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1200),
              delay: const Duration(milliseconds: 1500),
              child: GestureDetector(
                onTap: () {
                  context.navigateTo(const HomePage());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Start now",
                      style: TextStyle(
                          fontSize: 18,
                          color: scaffoldColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      CupertinoIcons.right_chevron,
                      color: scaffoldColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Body of the Onboarding stack
class OboardingBody extends StatelessWidget {
  const OboardingBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: context.responsive(420),
          ),

          /// App name with highlited 'T'
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            child: RichText(
                text: const TextSpan(style: TextStyle(fontSize: 30), children: [
              TextSpan(
                  text: "T",
                  style: TextStyle(
                      fontSize: 34,
                      color: buttonColor,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " .SHO",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ])),
          ),
          const SizedBox(
            height: 10,
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: const Text(
              "Start Journey \nWith Us",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 1300),
            child: const Text(
              "Smart, gorgeous & fashionable\ncollection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      height: 370,
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ZoomIn(
                child: Container(
                  height: context.responsive(230),
                  width: context.responsive(230),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFf6bd60)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ZoomIn(
                delay: const Duration(milliseconds: 700),
                child: Transform.rotate(
                  angle: pi * 1.85,
                  child: SizedBox(
                    height: context.responsive(250),
                    child: Image.asset(
                      "assets/onboarding_shoes.png",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Arc extends CustomPainter {
  final double height;
  final double width;
  final Color color;

  Arc(
    this.height,
    this.width,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var x = size.height / 2;
    var y = size.width / 2;

    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;

    var rect =
        Rect.fromCenter(center: Offset(x, y), width: width, height: height);

    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
