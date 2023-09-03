// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'method_channel.dart';

abstract class SharedPreferencesStorePlatform {
  static SharedPreferencesStorePlatform get instance => _instance;
  static set instance(SharedPreferencesStorePlatform value) {
    if (!value.isMock) {
      try {
        value._verifyProvidesDefaultImplementations();
      } on NoSuchMethodError catch (_) {
        throw AssertionError(
            'Platform interfaces must not be implemented with `implements`');
      }
    }
    _instance = value;
  }

  static SharedPreferencesStorePlatform _instance =
  MethodChannelSharedPreferencesStore();
  @visibleForTesting
  bool get isMock => false;

  Future<bool> remove(String key);
  Future<bool> setValue(String valueType, String key, Object value);
  Future<bool> clear();
  Future<Map<String, Object>> getAll();

  void _verifyProvidesDefaultImplementations() {}
}
class InMemorySharedPreferencesStore extends SharedPreferencesStorePlatform {
  InMemorySharedPreferencesStore.empty() : _data = <String, Object>{};
  InMemorySharedPreferencesStore.withData(Map<String, Object> data)
      : _data = Map<String, Object>.from(data);

  final Map<String, Object> _data;

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  Future<Map<String, Object>> getAll() async {
    return Map<String, Object>.from(_data);
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    _data[key] = value;
    return true;
  }
}
