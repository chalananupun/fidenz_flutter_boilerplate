
import 'package:fidenz_flutter_boilerplate/utility/url_launch/type_conversion.dart';

import 'LaunchMode.dart';
import 'LaunchOptions.dart';
import 'UrlLauncherPlatform.dart';

Future<bool> launchUrl(
    Uri url, {
      LaunchMode mode = LaunchMode.platformDefault,
      WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
      String? webOnlyWindowName,
    }) async {
  if (mode == LaunchMode.inAppWebView &&
      !(url.scheme == 'https' || url.scheme == 'http')) {
    throw ArgumentError.value(url, 'url',
        'To use an in-app web view, you must provide an http(s) URL.');
  }
  return UrlLauncherPlatform.instance.launchUrl(
    url.toString(),
    LaunchOptions(
      mode: convertLaunchMode(mode),
      webViewConfiguration: convertConfiguration(webViewConfiguration),
      webOnlyWindowName: webOnlyWindowName,
    ),
  );
}

Future<bool> canLaunchUrl(Uri url) async {
  return UrlLauncherPlatform.instance.canLaunch(url.toString());
}
Future<void> closeInAppWebView() async {
  return UrlLauncherPlatform.instance.closeWebView();
}
