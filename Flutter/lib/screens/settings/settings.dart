import 'package:digi3map/screens/homepage/widgets/homepage_drawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageDrawer(oldContext: context);
  }
}
