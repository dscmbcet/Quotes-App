import 'display.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:animations/animations.dart';
import 'package:animator/animator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBackground(
            // ignore: sort_child_properties_last
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: Icon(Icons.home),
                  title: Text(
                    "Lets Quote",
                    style: GoogleFonts.robotoSerif(),
                  ),
                  backgroundColor: Color(0xbb000000),
                  elevation: 0.0,
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Every man is a quotation \nfrom all his ancestors.",
                        style: GoogleFonts.fuzzyBubbles(
                          color: Colors.white,
                          fontSize: 22
                        ),
                      ),
                      Container(
                        width: 315,
                        padding: EdgeInsets.only(right: 40),
                        alignment: Alignment.centerRight,
                        child: Text("\n-Ralph Waldo Emerson",
                          style:GoogleFonts.fuzzyBubbles(
                          color: Colors.white,
                        ),),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        height: 50,
                        child: Animator(
                          duration: Duration(milliseconds: 1000),
                          cycles: 0,
                          curve: Curves.easeInOut,
                          tween: Tween<double>(begin: 0.0, end: 8.0),
                          builder: (context, animatorState, child) =>
                              OpenContainer(
                                  closedColor: Color(0x88012677),
                                  closedBuilder: (_, closeContainer) {
                                    return Container(
                                      margin:
                                          EdgeInsets.all(animatorState.value),
                                      height: 50,
                                      width: 200,
                                      child: Center(
                                        child: Text(
                                          "view quotes",
                                          style: GoogleFonts.roboto(
                                          color: Colors.white,
                                        ),
                                        ),
                                      ),
                                    );
                                  },
                                  middleColor: Colors.black,
                                  openColor: Colors.black,
                                  closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  transitionDuration:
                                      Duration(milliseconds: 700),
                                  openBuilder: (_, closedContainer) {
                                    return Anime();
                                  }),
                        ),
                      )
                    ],
                  ),
                )),
            vsync: this,
            behaviour: SpaceBehaviour()));
  }
}
