import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_music_app/core/constants/images.dart';

class ImageWrapper extends StatelessWidget {
  final Uint8List? image;
  const ImageWrapper({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Image.memory(
            image!,
            fit: BoxFit.fitHeight,
          )
        : Image.asset(
            CustomImages.defaultImage,
            fit: BoxFit.fill,
          );
  }
}
