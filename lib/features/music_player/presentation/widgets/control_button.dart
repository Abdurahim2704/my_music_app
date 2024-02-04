import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ControlButton extends StatelessWidget {
  final SvgPicture icon;
  final double size;
  final void Function() onPressed;
  const ControlButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox(
        height: size,
        width: size,
        child: icon,
      ),
    );
  }
}
