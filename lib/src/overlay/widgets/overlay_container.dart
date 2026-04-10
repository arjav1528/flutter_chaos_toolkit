import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    required this.child,
    required this.opacity,
    super.key,
  });

  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(8),
      child: Padding(padding: const EdgeInsets.all(8), child: child),
    );
  }
}
