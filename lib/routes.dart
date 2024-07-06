import 'package:flutter/material.dart';
import 'package:taskit/screens/identification_screen.dart';
import 'package:taskit/screens/main_screen.dart';
import 'package:taskit/wrapper.dart';

final routes = {
  '/': (BuildContext context) => const Wrapper(),
  '/identification': (BuildContext context) => const IdentificationScreen(),
  '/main': (BuildContext context) => const MainScreen(),
};
