
import 'package:flutter/material.dart';

import 'home_screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage())));
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
