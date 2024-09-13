import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/screen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Theme.of(context).colorScheme.surface,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // add image lottie
          LottieBuilder.asset('assets/Animation - 1725719063093.json'),
        ],
      ),
      // go to welcome screen
      nextScreen: const WelcomeScreen(),
      splashIconSize: 600,
      duration: 2000,
    );
  }
}
