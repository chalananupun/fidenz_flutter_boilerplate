
import 'package:flutter/foundation.dart';

enum LaunchMode {
  platformDefault,
  inAppWebView,
  externalApplication,
  externalNonBrowserApplication,
}

@immutable
class WebViewConfiguration {
  const WebViewConfiguration({
    this.enableJavaScript = true,
    this.enableDomStorage = true,
    this.headers = const <String, String>{},
  });

  final bool enableJavaScript;
  final bool enableDomStorage;
  final Map<String, String> headers;
}
