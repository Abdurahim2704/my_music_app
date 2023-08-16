import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> audioPermission() async {
    final result =  await Permission.audio.request();
    return result.isGranted;
  }

  static Future<bool> get isGrantedAudio async => await Permission.audio.isGranted;
}