import 'dart:math';

class GambleResult {
  int? x;
  int? y;
  int? z;

  GambleResult(this.x, this.y, this.z);

  void wipe() {
    x = null;
    y = null;
    z = null;
  }

  factory GambleResult.random() {
    var r = Random();

    return GambleResult(
      r.nextInt(10),
      r.nextInt(10),
      r.nextInt(10),
    );
  }
}
