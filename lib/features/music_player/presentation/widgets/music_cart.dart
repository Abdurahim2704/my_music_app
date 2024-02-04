import 'dart:ui';

import 'package:flutter/material.dart';

class MusicCart extends StatelessWidget {
  final Widget child;
  const MusicCart({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.withOpacity(0.16),
                        Colors.blue.withOpacity(0.05),
                      ])),
            ),
            child
          ],
        ),
      ),
    );
  }
}
