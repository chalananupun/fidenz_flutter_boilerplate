// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
typedef FollowLink = Future<void> Function();
typedef LinkWidgetBuilder = Widget Function(
    BuildContext context,
    FollowLink? followLink,
    );

typedef LinkDelegate = Widget Function(LinkInfo linkWidget);

const MethodCodec _codec = JSONMethodCodec();

class LinkTarget {
  const LinkTarget._({required this.debugLabel});
  final String debugLabel;

  static const LinkTarget defaultTarget =
  LinkTarget._(debugLabel: 'defaultTarget');

  static const LinkTarget self = LinkTarget._(debugLabel: 'self');

  static const LinkTarget blank = LinkTarget._(debugLabel: 'blank');
}

abstract class LinkInfo {
  LinkWidgetBuilder get builder;
  Uri? get uri;
  LinkTarget get target;

  bool get isDisabled;
}

typedef _SendMessage = Function(String, ByteData?, void Function(ByteData?));

Future<ByteData> pushRouteNameToFramework(Object? _, String routeName) {
  final Completer<ByteData> completer = Completer<ByteData>();
  SystemNavigator.routeInformationUpdated(location: routeName);
  final _SendMessage sendMessage = _ambiguate(WidgetsBinding.instance)
      ?.platformDispatcher
      .onPlatformMessage ??
      ui.channelBuffers.push;
  sendMessage(
    'flutter/navigation',
    _codec.encodeMethodCall(
      MethodCall('pushRouteInformation', <dynamic, dynamic>{
        'location': routeName,
        'state': null,
      }),
    ),
    completer.complete,
  );
  return completer.future;
}


T? _ambiguate<T>(T? value) => value;
