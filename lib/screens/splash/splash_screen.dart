import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {

  final String nextRoute;

  SplashScreen({this.nextRoute});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 6),
            () { Navigator.of(context).pushReplacementNamed(widget.nextRoute); }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack( children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child:
                SvgPicture.asset('assets/images/splash_screen.svg'),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/animations/custom_preloader.gif')
          )
        ],
        ),
      ),
    );
  }

}