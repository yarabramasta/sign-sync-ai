import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/signsyncai-logo.png',
          width: 72,
          height: 72,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
