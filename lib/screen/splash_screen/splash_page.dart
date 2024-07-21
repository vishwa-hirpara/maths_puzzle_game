import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maths_puzzle/screen/home_screen/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(


//--------------------------------------Lottie------------------------------
        child: Lottie.asset(
          'assets/lottie/splash_lottie.json',
          fit: BoxFit.fill,
          onLoaded: (compose) {
            _animationController
              ..duration = compose.duration
              ..forward().whenComplete(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
