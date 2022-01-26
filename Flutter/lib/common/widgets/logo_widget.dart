import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Digi ⚡ Map",
      style: Styles.logoTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
