import 'dart:io';
import 'dart:typed_data';


class Track {
  String name;
  Duration duration;
  String path;
  Uint8List? image;

  Track({required this.name, required this.path, required this.duration, this.image});
}
