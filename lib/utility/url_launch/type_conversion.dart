
import 'LaunchMode.dart';
import 'LaunchOptions.dart';

InAppWebViewConfiguration convertConfiguration(WebViewConfiguration config) {
  return InAppWebViewConfiguration(
    enableJavaScript: config.enableJavaScript,
    enableDomStorage: config.enableDomStorage,
    headers: config.headers,
  );
}

PreferredLaunchMode convertLaunchMode(LaunchMode mode) {
  switch (mode) {
    case LaunchMode.platformDefault:
      return PreferredLaunchMode.platformDefault;
    case LaunchMode.inAppWebView:
      return PreferredLaunchMode.inAppWebView;
    case LaunchMode.externalApplication:
      return PreferredLaunchMode.externalApplication;
    case LaunchMode.externalNonBrowserApplication:
      return PreferredLaunchMode.externalNonBrowserApplication;
  }
}
