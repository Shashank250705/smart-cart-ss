import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc_flutter/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: double.maxFinite,
      child: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Lottie.asset(
                "asset/Animation_1717953387196.json",
                width: 700, // Adjust width and height as needed
                height: 700,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        nextScreen: const WelcomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.blue,
        duration: 3000,
      ),
    );
  }
}
