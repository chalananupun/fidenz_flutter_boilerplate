import 'package:flutter/services.dart';

import 'UrlLauncherPlatform.dart';
import 'links.dart';

const MethodChannel _channel = MethodChannel('plugins.flutter.io/url_launcher');

class MethodChannelUrlLauncher extends UrlLauncherPlatform {
  @override
  final LinkDelegate? linkDelegate = null;

  @override
  Future<bool> canLaunch(String url) {
    return _channel.invokeMethod<bool>(
      'canLaunch',
      <String, Object>{'url': url},
    ).then((bool? value) => value ?? false);
  }

  @override
  Future<void> closeWebView() {
    return _channel.invokeMethod<void>('closeWebView');
  }

  @override
  Future<bool> launch(
      String url, {
        required bool useSafariVC,
        required bool useWebView,
        required bool enableJavaScript,
        required bool enableDomStorage,
        required bool universalLinksOnly,
        required Map<String, String> headers,
        String? webOnlyWindowName,
      }) {
    return _channel.invokeMethod<bool>(
      'launch',
      <String, Object>{
        'url': url,
        'useSafariVC': useSafariVC,
        'useWebView': useWebView,
        'enableJavaScript': enableJavaScript,
        'enableDomStorage': enableDomStorage,
        'universalLinksOnly': universalLinksOnly,
        'headers': headers,
      },
    ).then((bool? value) => value ?? false);
  }
}
