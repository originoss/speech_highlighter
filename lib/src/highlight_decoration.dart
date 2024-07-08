import 'package:flutter/material.dart';

class HighlightDecoration {
  /// Color of the highlight background
  /// 
  /// Defaults to [Colors.red]
  final Color color;

  /// Border radius of the highlight
  /// 
  /// Defaults to [Radius.circular(4)]
  final Radius borderRadius;

  const HighlightDecoration({
    required this.color,
    this.borderRadius = const Radius.circular(4),
  });
}
