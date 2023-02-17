import 'dart:ui';

import 'package:clock_application/timeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'clock_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageClock(),
    );
  }
}

class HomePageClock extends StatefulWidget {
  const HomePageClock({super.key});

  @override
  State<HomePageClock> createState() => _HomePageClockState();
}

class _HomePageClockState extends State<HomePageClock> {
  static DateTime currentTime = DateTime.now();

  Stream timer = Stream.periodic(Duration(seconds: 1), (i) {
    currentTime = currentTime.add(Duration(seconds: 1));
    return currentTime;
  });

  _listenerToTime() {
    timer.listen((event) {
      //print(event);
      currentTime = DateTime.parse(event.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenerToTime();
    // timerControllerGet.startTimer().listen((event) {
    //   print(event.toString());
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    timer.drain();
    super.dispose();
  }

  TimerController timerControllerGet = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // //backgroundColor: Colors.grey.withOpacity(0.5),
      // backgroundColor: Color(0xff110817),
      //backgroundColor: Colors.grey.withOpacity(0.5),
      backgroundColor: Color(0xff262626),
      body: SafeArea(
        child: GetBuilder<TimerController>(builder: (context) {
          return Container(
            height: size.height,
            width: size.width,
            child: OrientationBuilder(
              builder: (context, layout) {
                if (layout == Orientation.landscape) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClockPage(
                        onTime: currentTime.hour,
                        limit: 24,
                        start: 00,
                        timerDuration:
                            Duration(minutes: 60 - currentTime.minute),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // this is gonna be minutes wala
                      ClockPage(
                        onTime: currentTime.minute,
                        limit: 59,
                        start: 00,
                        timerDuration:
                            Duration(seconds: 60 - currentTime.second),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // this is seconds wala
                      ClockPage(
                        onTime: currentTime.second,
                        limit: 59,
                        start: 00,
                        timerDuration: Duration(seconds: 1),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // this is gonna be hours wala
                      ClockPage(
                        onTime: currentTime.hour,
                        limit: 24,
                        start: 00,
                        timerDuration:
                            Duration(minutes: 60 - currentTime.minute),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // this is gonna be minutes wala
                      ClockPage(
                        onTime: currentTime.minute,
                        limit: 59,
                        start: 00,
                        timerDuration:
                            Duration(seconds: 60 - currentTime.second),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // this is seconds wala
                      ClockPage(
                        onTime: currentTime.second,
                        limit: 59,
                        start: 00,
                        timerDuration: Duration(seconds: 1),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}

class FrostedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: new Container(
                // width: 200.0,
                // height: 200.0,
                // decoration: new BoxDecoration(
                //     color: Colors.grey.shade200.withOpacity(0.5)),
                ),
          ),
        ),
      ],
    );
  }
}
