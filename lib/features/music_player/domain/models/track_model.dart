import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final String author;
  final String name;
  final Duration duration;
  final String path;
  final Uint8List? image;

  const Track({
    required this.name,
    required this.path,
    required this.duration,
    this.image,
    required this.author,
  });

  @override
  List<Object?> get props => [name, path];

  @override
  String toString() {
    return "Track($name, $duration, $path)";
  }
}
