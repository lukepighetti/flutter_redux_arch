import 'dart:typed_data';

import 'package:redux_persist/redux_persist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements StorageEngine {
  /// Storage engine for `redux_persist`.
  SharedPreferencesStorage([this.key = "app"]);

  /// Shared preferences key to save to.
  final String key;

  SharedPreferences _prefs;

  Future<void> setup() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<Uint8List> load() async {
    if (_prefs == null) await setup();
    return stringToUint8List(_prefs.getString(key));
  }

  @override
  Future<void> save(Uint8List data) async {
    _prefs.setString(key, uint8ListToString(data));
  }
}
