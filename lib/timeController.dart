import 'package:get/get.dart';

class TimerController extends GetxController {
  var currentTime = DateTime.now().obs;

  // Future startTimer() async {
  //   // currentTime.value = DateTime.now();
  //   while (true) {
  //     await Future.delayed(Duration(seconds: 1));
  //     currentTime.value.add(Duration(seconds: 1));
  //     print(currentTime.value.toString());
  //   }
  // }

  // Stream timer = Stream.periodic(Duration(seconds: 1), (i) {
  //   currentTime.value = currentTime.add(Duration(seconds: 1));
  //   return currentTime;
  // });

  Stream<DateTime> startTimer() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1)).then((value) {
        currentTime.value = currentTime.value.add(Duration(seconds: 1));
      });
      print(currentTime.value.second);
      yield currentTime.value;
    }
  }
}
