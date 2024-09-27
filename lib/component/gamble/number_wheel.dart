import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackathon24/constants/gamble_constants.dart';
import 'package:hackathon24/constants/theme_data.dart';

class NumberWheel extends StatelessWidget {
  const NumberWheel({
    super.key,
    required this.width,
    this.value,
  });

  final double width;
  final int? value;

  @override
  Widget build(BuildContext context) {
    double height = width * 1.4142135624;

    return Card(
      color: const Color.fromRGBO(245, 254, 231, 1.0),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: value == null
              ? SpinKitRotatingCircle(
                  color: kelagGreen,
                  size: width / 2,
                )
              : _NumberFruit(value: value!),
        ),
      ),
    );
  }
}

class _NumberFruit extends StatelessWidget {
  const _NumberFruit({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "$gambleAssetPath$value.png",
      fit: BoxFit.contain,
    );
  }
}
