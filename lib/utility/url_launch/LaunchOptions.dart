
import 'package:flutter/foundation.dart';

enum PreferredLaunchMode {
  platformDefault,
  inAppWebView,
  externalApplication,
  externalNonBrowserApplication,
}

@immutable
class InAppWebViewConfiguration {
  const InAppWebViewConfiguration({
    this.enableJavaScript = true,
    this.enableDomStorage = true,
    this.headers = const <String, String>{},
  });

  final bool enableJavaScript;
  final bool enableDomStorage;
  final Map<String, String> headers;
}

@immutable
class LaunchOptions {
  const LaunchOptions({
    this.mode = PreferredLaunchMode.platformDefault,
    this.webViewConfiguration = const InAppWebViewConfiguration(),
    this.webOnlyWindowName,
  });

  final PreferredLaunchMode mode;
  final InAppWebViewConfiguration webViewConfiguration;
  final String? webOnlyWindowName;
}
