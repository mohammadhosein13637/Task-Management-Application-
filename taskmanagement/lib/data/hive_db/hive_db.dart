import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagement/toolkit/tool_kit.dart' as tool_kit;

abstract class HiveDB {
  //

  static Future<List<int>> _getInc() async {
    final sp = await SharedPreferences.getInstance();
    final deviceId = await tool_kit.Utils.getDeviceUid();
    var key = sp.getStringList(deviceId);
    if (key != null) {
      return key.map((e) {
        return int.parse(e) - 5;
      }).toList();
    }
    return await _setInc();
  }

  static Future<List<int>> _setInc() async {
    final key = Hive.generateSecureKey();
    final sp = await SharedPreferences.getInstance();
    final deviceId = await tool_kit.Utils.getDeviceUid();
    sp.setStringList(
        deviceId,
        key.map((e) {
          return (e + 5).toString();
        }).toList());
    return key;
  }

  static Future<void> init({required String appName}) async {
    if (kIsWeb) {
      Hive.init('');
    } else {
      final docDir = await getApplicationDocumentsDirectory();
      final appDir = await Directory('${docDir.path}/$appName').create();
      Hive.init(appDir.path);
    }
  }

  static Future<void> openBox({required String boxName}) async {
    await Hive.openBox(
      boxName,
      crashRecovery: true,
      encryptionCipher: HiveAesCipher(await _getInc()),
    );
  }

  static void setValue<T>({
    required String box,
    required int key,
    required T value,
  }) {
    if (!Hive.isBoxOpen(box)) {
      throw Exception('$box box is not openned yet!');
    }
    Hive.box(box).put(key.toString(), value);
  }

  static T? getValue<T>({
  required String box,
  required int key,
  T? Function(dynamic)? fromJson, // Added parameter to parse the value
}) {
  if (!Hive.isBoxOpen(box)) {
    throw Exception('$box box is not opened yet!');
  }
  final dynamic value = Hive.box(box).get(key.toString());
  return fromJson != null ? fromJson(value) : value as T?;
}

}
