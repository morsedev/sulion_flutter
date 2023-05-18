import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatasource {
  Future<T?> get<T extends Storable>(String key, Storable intance);
  Future<bool> put<T extends Storable>(String key, T data);
  Future<bool> delete<T>(String key);
  void reset();
}

class LocalDatasourceImpl implements LocalDatasource {
  Future<SharedPreferences> get _preferences async =>
      await SharedPreferences.getInstance();

  @override
  Future<bool> delete<T>(String key) async {
    return (await _preferences).remove(key);
  }

  @override
  Future<T?> get<T extends Storable>(String key, Storable instance) async {
    String? encodedString = (await _preferences).getString(key);
    if (encodedString == null) {
      return null;
    }
    final encoded = jsonDecode(encodedString) as Map<String, dynamic>;
    return instance.fromStorage(encoded) as T;
  }

  @override
  Future<bool> put<T extends Storable>(String key, T data) async {
    return (await _preferences).setString(key, jsonEncode(data.toStorage()));
  }

  @override
  Future<void> reset() async {
    (await _preferences).clear();
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
