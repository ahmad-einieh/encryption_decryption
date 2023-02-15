import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

var backgroundStartColor = const Color(0xFFFFD500);
var backgroundEndColor = const Color(0xFFF6A00C);

var buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

// redaccent is the color of the button and textfiled

var mainDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.0, 1.0],
    colors: [backgroundStartColor, backgroundEndColor],
  ),
);

const mainTextStyle =
    TextStyle(color: Colors.cyan, fontSize: 32, fontWeight: FontWeight.bold);
const selectListLabelSytle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
