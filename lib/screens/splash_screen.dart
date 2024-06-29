import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc_flutter/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

//.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*const Text(
              'Simply pay',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
                height: 20),*/ // Add some space between the text and animation
            Expanded(
              child: Lottie.asset(
                "asset/Animation_1717953387196.json",
                width: 1500, // Adjust width and height as needed
                height: 1500,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
        nextScreen: const WelcomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        duration: 3000,
      ),
    );
  }
}
