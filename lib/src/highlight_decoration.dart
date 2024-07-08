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

  /// Padding of the highlight
  /// 
  /// Defaults to [EdgeInsets.zero]
  final EdgeInsets padding;

  const HighlightDecoration({
    required this.color,
    this.borderRadius = const Radius.circular(4),
    this.padding = EdgeInsets.zero,
  });
}
