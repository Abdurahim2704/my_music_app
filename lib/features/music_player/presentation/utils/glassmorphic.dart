import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

final _borderRadius = BorderRadius.all(Radius.circular(0));

class GlassMorphic extends StatelessWidget {
  final child;
  final Color beginColor;
  final Color endColor;

  const GlassMorphic({
    super.key,
    this.child = null,
    required this.beginColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              gradient: LinearGradient(
                transform: const GradientRotation(pi * 90 / 180),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  beginColor,
                  endColor,
                ],
              ),
            ),
          ),
          Center(
            child: child,
          ),
        ],
      ),
    );
  }
}
