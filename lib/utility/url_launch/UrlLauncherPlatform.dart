import 'LaunchOptions.dart';
import 'MethodChannelUrlLauncher.dart';
import 'PlatformInterface.dart';
import 'links.dart';

abstract class UrlLauncherPlatform extends PlatformInterface {

  UrlLauncherPlatform() : super(token: _token);

  static final Object _token = Object();

  static UrlLauncherPlatform _instance = MethodChannelUrlLauncher();

  static UrlLauncherPlatform get instance => _instance;

  static set instance(UrlLauncherPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }
  LinkDelegate? get linkDelegate;
  Future<bool> canLaunch(String url) {
    throw UnimplementedError('canLaunch() has not been implemented.');
  }

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
    throw UnimplementedError('launch() has not been implemented.');
  }

  Future<bool> launchUrl(String url, LaunchOptions options) {
    final bool isWebURL = url.startsWith('http:') || url.startsWith('https:');
    final bool useWebView = options.mode == PreferredLaunchMode.inAppWebView ||
        (isWebURL && options.mode == PreferredLaunchMode.platformDefault);

    return launch(
      url,
      useSafariVC: useWebView,
      useWebView: useWebView,
      enableJavaScript: options.webViewConfiguration.enableJavaScript,
      enableDomStorage: options.webViewConfiguration.enableDomStorage,
      universalLinksOnly:
      options.mode == PreferredLaunchMode.externalNonBrowserApplication,
      headers: options.webViewConfiguration.headers,
      webOnlyWindowName: options.webOnlyWindowName,
    );
  }

  Future<void> closeWebView() {
    throw UnimplementedError('closeWebView() has not been implemented.');
  }
}
