import 'dart:math';

class BackendService {
  Future<void> httpCall() async {
    await Future.delayed(Duration(milliseconds: Random().nextInt(1500)));
  }
}
