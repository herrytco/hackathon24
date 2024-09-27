import 'dart:math';

class GambleResult {
  int? x;
  int? y;
  int? z;

  GambleResult([this.x, this.y, this.z]);

  void wipe() {
    x = null;
    y = null;
    z = null;
  }

  void roll() {
    var r = Random();

    x = r.nextInt(10);
    y = r.nextInt(10);
    z = r.nextInt(10);
  }

  bool get isWin => x == y && y == z;

  factory GambleResult.random() {
    return GambleResult()..roll();
  }
}
