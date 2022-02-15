import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Text(
      "Digi ⚡ Map",
      style: Styles.logoTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
