
import 'package:flutter/material.dart';

class Badge {
  final Color? color;
  final Color? badgeColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final String? text;

  const Badge(
    this.text, {
    @required this.color,
    @required this.badgeColor,
    @required this.padding,
    @required this.borderRadius,
  });
}
