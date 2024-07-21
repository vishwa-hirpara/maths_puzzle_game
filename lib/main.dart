import 'package:flutter/material.dart';
import 'package:maths_puzzle/screen/splash_screen/splash_page.dart';
import 'package:maths_puzzle/services/pref_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await PrefService.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      // PlayPage(index: 1,),
      theme:  ThemeData(fontFamily: 'chalk'),
      // MainSplashScreenFile(),
    ),
  );
}
