class ActivatedService {
  final List<String> activated = <String>[];

  void activate(string) {
    activated.add(string);
  }

  bool isActivated(string) {
    return activated.contains(string);
  }
}
