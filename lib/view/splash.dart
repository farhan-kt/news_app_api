import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_api/view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset('assets/Animation - splash.json',
              fit: BoxFit.fill,
              height: mediaQuery.height * 0.5,
              width: mediaQuery.width * 0.7),
          SizedBox(
            height: mediaQuery.height * 0.04,
            width: mediaQuery.width * 0.04,
          ),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.anton(
                letterSpacing: .5, color: Colors.grey.shade500),
          ),
          SizedBox(
            height: mediaQuery.height * 0.04,
            width: mediaQuery.width * 0.04,
          ),
          SpinKitChasingDots(
            color: Colors.grey.shade500,
            size: 30,
          )
        ]),
      ),
    );
  }
}
