import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> audioPermission() async {
    if (await Permission.audio.isGranted) return true;

    final result = await Permission.audio.request();
    final result2 = await Permission.storage.request();
    return result.isGranted || result2.isGranted;
  }

  static Future<bool> get isGrantedAudio async =>
      (await Permission.audio.isGranted) ||
      (await Permission.storage.isGranted);
}
