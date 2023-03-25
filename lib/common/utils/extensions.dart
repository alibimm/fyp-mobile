import 'package:flutter/material.dart';

extension BuildContextSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension DoubleSizedBox on double {
  SizedBox get hSpace => SizedBox(width: this);
  SizedBox get vSpace => SizedBox(height: this);
}