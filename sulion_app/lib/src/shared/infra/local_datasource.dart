import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatasource {
  Future<T?> get<T extends Storable>(String key, Storable intance);
  Future<bool> put<T extends Storable>(String key, T data);
  Future<bool> delete<T>(String key);
  void reset();
}

class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl() {
    SharedPreferences.getInstance().then((prefs) => _preferences = prefs);
  }
  late SharedPreferences _preferences;

  @override
  Future<bool> delete<T>(String key) async {
    return _preferences.remove(key);
  }

  @override
  Future<T?> get<T extends Storable>(String key, Storable instance) async {
    String? encodedString = _preferences.getString(key);
    if (encodedString == null) {
      return null;
    }
    final encoded = jsonDecode(encodedString) as Map<String, dynamic>;
    return instance.fromStorage(encoded) as T;
  }

  @override
  Future<bool> put<T extends Storable>(String key, T data) {
    return _preferences.setString(key, jsonEncode(data.toStorage()));
  }

  @override
  void reset() {
    _preferences.clear();
  }
}

class Storable {
  Storable();
  Map<String, dynamic> toStorage() {
    throw UnimplementedError();
  }

  Storable fromStorage(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
