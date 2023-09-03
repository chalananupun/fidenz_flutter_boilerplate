// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'SharedPreferencesStorePlatform.dart';

class SharedPreferences {
  SharedPreferences._(this._preferenceCache);

  static const String _prefix = 'flutter.';
  static Completer<SharedPreferences>? _completer;

  static SharedPreferencesStorePlatform get _store =>
      SharedPreferencesStorePlatform.instance;


  static Future<SharedPreferences> getInstance() async {
    if (_completer == null) {
      final Completer<SharedPreferences> completer =
      Completer<SharedPreferences>();
      try {
        final Map<String, Object> preferencesMap =
        await _getSharedPreferencesMap();
        completer.complete(SharedPreferences._(preferencesMap));
      } on Exception catch (e) {
        completer.completeError(e);
        final Future<SharedPreferences> sharedPrefsFuture = completer.future;
        _completer = null;
        return sharedPrefsFuture;
      }
      _completer = completer;
    }
    return _completer!.future;
  }

  final Map<String, Object> _preferenceCache;

  Set<String> getKeys() => Set<String>.from(_preferenceCache.keys);

  Object? get(String key) => _preferenceCache[key];

  bool? getBool(String key) => _preferenceCache[key] as bool?;

  int? getInt(String key) => _preferenceCache[key] as int?;

  double? getDouble(String key) => _preferenceCache[key] as double?;

  String? getString(String key) => _preferenceCache[key] as String?;

  bool containsKey(String key) => _preferenceCache.containsKey(key);

  List<String>? getStringList(String key) {
    List<dynamic>? list = _preferenceCache[key] as List<dynamic>?;
    if (list != null && list is! List<String>) {
      list = list.cast<String>().toList();
      _preferenceCache[key] = list;
    }
    // Make a copy of the list so that later mutations won't propagate
    return list?.toList() as List<String>?;
  }

  Future<bool> setBool(String key, bool value) => _setValue('Bool', key, value);

  Future<bool> setInt(String key, int value) => _setValue('Int', key, value);

  Future<bool> setDouble(String key, double value) =>
      _setValue('Double', key, value);

  Future<bool> setString(String key, String value) =>
      _setValue('String', key, value);

  Future<bool> setStringList(String key, List<String> value) =>
      _setValue('StringList', key, value);

  Future<bool> remove(String key) {
    final String prefixedKey = '$_prefix$key';
    _preferenceCache.remove(key);
    return _store.remove(prefixedKey);
  }

  Future<bool> _setValue(String valueType, String key, Object value) {
    ArgumentError.checkNotNull(value, 'value');
    final String prefixedKey = '$_prefix$key';
    if (value is List<String>) {
      // Make a copy of the list so that later mutations won't propagate
      _preferenceCache[key] = value.toList();
    } else {
      _preferenceCache[key] = value;
    }
    return _store.setValue(valueType, prefixedKey, value);
  }

  @deprecated
  Future<bool> commit() async => true;

  Future<bool> clear() {
    _preferenceCache.clear();
    return _store.clear();
  }

  Future<void> reload() async {
    final Map<String, Object> preferences =
    await SharedPreferences._getSharedPreferencesMap();
    _preferenceCache.clear();
    _preferenceCache.addAll(preferences);
  }

  static Future<Map<String, Object>> _getSharedPreferencesMap() async {
    final Map<String, Object> fromSystem = await _store.getAll();
    assert(fromSystem != null);
    // Strip the flutter. prefix from the returned preferences.
    final Map<String, Object> preferencesMap = <String, Object>{};
    for (final String key in fromSystem.keys) {
      assert(key.startsWith(_prefix));
      preferencesMap[key.substring(_prefix.length)] = fromSystem[key]!;
    }
    return preferencesMap;
  }

  @visibleForTesting
  static void setMockInitialValues(Map<String, Object> values) {
    final Map<String, Object> newValues =
    values.map<String, Object>((String key, Object value) {
      String newKey = key;
      if (!key.startsWith(_prefix)) {
        newKey = '$_prefix$key';
      }
      return MapEntry<String, Object>(newKey, value);
    });
    SharedPreferencesStorePlatform.instance =
        InMemorySharedPreferencesStore.withData(newValues);
    _completer = null;
  }
}
