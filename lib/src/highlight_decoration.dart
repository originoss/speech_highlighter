import 'package:flutter/material.dart';

class HighlightDecoration {
  final Color color;
  final Radius borderRadius;

  const HighlightDecoration({
    required this.color,
    this.borderRadius = const Radius.circular(4),
  });
}
