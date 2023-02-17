import 'dart:async';
import 'dart:ui';

import 'package:clock_application/timeController.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class ClockPage extends StatefulWidget {
  int onTime;
  final Duration timerDuration;
  final int limit;
  final int start;
  ClockPage(
      {super.key,
      required this.onTime,
      required this.timerDuration,
      required this.limit,
      required this.start});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage>
    with SingleTickerProviderStateMixin {
  // datatypes
  TimerController timerControllerNew = Get.find();
  late Animation _animation;
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation =
        Tween<double>(end: math.pi, begin: math.pi * 2).animate(_controller);

    _animation.addListener(() {
      setState(() {});
    });
    startTimer();
  }

  // seconds have a limit of 59 seconds
  //  minutes have a limiit of 59 minutes
  // hours have a limit of 12 or 24 depending on the hour mode
  late Timer _timer;
  startTimer() {
    Duration flipperDuration = widget.timerDuration;
    _timer = Timer.periodic(flipperDuration, (timer) {
      if (widget.onTime == widget.limit) {
        widget.onTime = 00;
        timerControllerNew.update();
        setState(() {});
      } else if (widget.onTime != widget.limit) {
        _controller.reset();
        _controller.forward();
        widget.onTime++;
      }
    });
  }

  BoxDecoration _boxDecoration(bool top) {
    return BoxDecoration(
        color: Color(0xff303030),
        //color: Colors.black,
        //color: Color(0xffFF4D4F),
        //color: Color(0xff22162A),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(
              4.0,
              4.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(top ? 10 : 0),
          topRight: Radius.circular(top ? 10 : 0),
          bottomLeft: Radius.circular(top ? 0 : 10),
          bottomRight: Radius.circular(top ? 0 : 10),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  // 1st half container A
                  Container(
                      decoration: _boxDecoration(true),
                      height: 99,
                      width: 200,
                      //color: Colors.red,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 40,
                            child: _clockTimerWidget(),
                          )
                        ],
                      )),

                  //  divider here
                  // Divider(
                  //   height: 2,
                  //   color: Colors.black,
                  // ),

                  // second half container B this will be helping in the animation from bottom to top
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 99,
                        width: 200,
                        decoration: _boxDecoration(false),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 40,
                              //left: 36,
                              child: _clockTimerWidget(),
                            )
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _animation,

                        // this container will have future second
                        child: Container(
                          height: 100,
                          width: 200,
                          //decoration: _boxDecoration(false),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _animation.value > 4.71
                                  ? Positioned(
                                      bottom: 40,
                                      child: _clockTimerWidget(),
                                    )
                                  : Positioned(
                                      top: 60,
                                      child: Transform(
                                        transform: Matrix4.rotationX(math.pi),
                                        child: _clockTimerWidget(),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(_animation.value),
                            child: child,
                          );
                        },
                      ),
                    ],
                  ),

                  // 2nd stack child ==> animation part
                ],
              ),
              Container(
                width: 200,
                child: Row(children: [
                  Container(
                    height: 25,
                    width: 7,
                    color: Color(0xff110817),
                  ),
                  Container(
                    width: 186,
                    height: 2,
                    //color: Colors.black,
                    color: Color(0xff110817),
                  ),
                  Container(
                    height: 25,
                    width: 7,
                    color: Color(0xff110817),
                  ),
                ]),
              ),
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //             color: Colors.red,
              //             borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(10),
              //               topRight: Radius.circular(0),
              //               //bottomLeft: Radius.circular(10),
              //               bottomRight: Radius.circular(0),
              //             )),
              //         width: 10,
              //         height: 30,
              //       ),
              //       Container(
              //         width: 180,
              //         height: 10,
              //         color: Color(0xffFF4D4F),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //             color: Colors.red,
              //             borderRadius: BorderRadius.only(
              //               //topLeft: Radius.circular(10),
              //               topRight: Radius.circular(10),
              //               //bottomLeft: Radius.circular(10),
              //               // bottomRight: Radius.circular(10),
              //             )),
              //         width: 10,
              //         height: 10,
              //       ),
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }

  Widget _clockTimerWidget() {
    return Container(
      child: Text(
        widget.onTime.toString().padLeft(2, "0"),
        style: TextStyle(color: Colors.white70, fontSize: 100),
      ),
    );
  }
}
