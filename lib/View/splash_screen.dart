import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bootcamp_2023_w5/View/world_states.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState(){
    super.initState();

    Timer(const Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStatesScreen()))
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('lib/assets/virus.png')),
                  ),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(angle: _controller.value * 2.0 * math.pi,
                  child: child,);
                }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            Align(
              alignment: Alignment.center,
                child: Text('Covid-19\nTracker App',textAlign: TextAlign.center, style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 25),)),
            
          ],
        ),
      ),
    );
  }
}
