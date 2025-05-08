import 'package:flutter/material.dart';

import 'widgets/animated_splash_child.dart';

class SplashScreen extends StatelessWidget {
  final int duration = 2000;

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF000000)),
        child: AnimatedSplashChild(
          next: () {
            // AppNavigate.pushReplacementNamed(RouteList.cities);
          },
          imagePath: 'assets/logo/car_on_sale_logo.png',
          duration: duration,
          animationEffect: SplashScreenTypeConstants.fadeIn,
          boxFit: BoxFit.contain,
          size: Size(size.width * 0.55, size.height * 0.25),
        ),
      ),
    );
  }
}
