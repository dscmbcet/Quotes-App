import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Anime extends StatefulWidget {
  const Anime({super.key});

  @override
  State<Anime> createState() => _AnimeState();
}

class _AnimeState extends State<Anime> with TickerProviderStateMixin {
  List _items = [];
  var len = 9;
  var show = false;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final data = await json.decode(response);

    setState(() {
      _items = data["items"];
      len = _items.length;
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          show = true;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
    
  }
// Fetch content from the json file

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedBackground(
        vsync: this,
        behaviour: RectanglesBehaviour(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0x44000000),
          ),
          backgroundColor: Colors.transparent,
          body: AnimationLimiter(
              child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: len,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: _w / 10),
                      height: _w / 2.5,
                      decoration: BoxDecoration(
                        color: Color(0xdffdfac7),
                        //border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: show
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  child: Center(
                                      child: Text("\"" +
                                          _items[index]['quote'] +
                                          "\"",style: GoogleFonts.kalam(fontSize: 20),)),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child:
                                      Text(" - " + _items[index]['author'],style: GoogleFonts.roboto(),),
                                )
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
              );
            },
          )),
        ),
      ),
    );
  }
}
