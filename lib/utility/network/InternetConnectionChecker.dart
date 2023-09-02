

import 'dart:async';
import 'dart:io';

import 'AddressCheckOptions.dart';
import 'AddressCheckResult.dart';
import 'InternetConnectionStatus.dart';

class InternetConnectionChecker {

  factory InternetConnectionChecker() => _instance;
  InternetConnectionChecker._() {
 
    _statusController.onListen = () {
      _maybeEmitStatusUpdate();
    };

    // stop sending status updates when no one is listening
    _statusController.onCancel = () {
      _timerHandle?.cancel();
      _lastStatus = null; // reset last status
    };
  }

  static const int DEFAULT_PORT = 53;

  static const Duration DEFAULT_TIMEOUT = Duration(seconds: 10);

  static const Duration DEFAULT_INTERVAL = Duration(seconds: 10);

  /// | Address        | Provider   | Info                                            |
  /// |:---------------|:-----------|:------------------------------------------------|
  /// | 1.1.1.1        | CloudFlare | https://1.1.1.1                                 |
  /// | 1.0.0.1        | CloudFlare | https://1.1.1.1                                 |
  /// | 8.8.8.8        | Google     | https://developers.google.com/speed/public-dns/ |
  /// | 8.8.4.4        | Google     | https://developers.google.com/speed/public-dns/ |
  /// | 208.67.222.222 | OpenDNS    | https://use.opendns.com/                        |
  /// | 208.67.220.220 | OpenDNS    | https://use.opendns.com/                        |
  static final List<AddressCheckOptions> DEFAULT_ADDRESSES =
  List<AddressCheckOptions>.unmodifiable(
    <AddressCheckOptions>[
      AddressCheckOptions(
        InternetAddress(
          '1.1.1.1', // CloudFlare
          type: InternetAddressType.IPv4,
        ),
      ),
      AddressCheckOptions(
        InternetAddress(
          '2606:4700:4700::1111', // CloudFlare
          type: InternetAddressType.IPv6,
        ),
      ),
      AddressCheckOptions(
        InternetAddress(
          '8.8.4.4', // Google
          type: InternetAddressType.IPv4,
        ),
      ),
      AddressCheckOptions(
        InternetAddress(
          '2001:4860:4860::8888', // Google
          type: InternetAddressType.IPv6,
        ),
      ),
      AddressCheckOptions(
        InternetAddress(
          '208.67.222.222', // OpenDNS
          type: InternetAddressType.IPv4,
        ), // OpenDNS
      ),
      AddressCheckOptions(
        InternetAddress(
          '2620:0:ccc::2', // OpenDNS
          type: InternetAddressType.IPv6,
        ), // OpenDNS
      ),
    ],
  );


  List<AddressCheckOptions> addresses = DEFAULT_ADDRESSES;

  static final InternetConnectionChecker _instance =
  InternetConnectionChecker._();

  Future<AddressCheckResult> isHostReachable(
      AddressCheckOptions options,
      ) async {
    Socket? sock;
    try {
      sock = await Socket.connect(
        options.address,
        options.port,
        timeout: options.timeout,
      )
        ..destroy();
      return AddressCheckResult(
        options,
        true,
      );
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(
        options,
        false,
      );
    }
  }

  Future<bool> get hasConnection async {
    final Completer<bool> result = Completer<bool>();
    int length = addresses.length;

    for (final AddressCheckOptions addressOptions in addresses) {
      // ignore: unawaited_futures
      isHostReachable(addressOptions).then(
            (AddressCheckResult request) {
          length -= 1;
          if (!result.isCompleted) {
            if (request.isSuccess) {
              result.complete(true);
            } else if (length == 0) {
              result.complete(false);
            }
          }
        },
      );
    }

    return result.future;
  }

  Future<InternetConnectionStatus> get connectionStatus async {
    return await hasConnection
        ? InternetConnectionStatus.connected
        : InternetConnectionStatus.disconnected;
  }

  Duration checkInterval = DEFAULT_INTERVAL;

  Future<void> _maybeEmitStatusUpdate([
    Timer? timer,
  ]) async {
    _timerHandle?.cancel();
    timer?.cancel();

    final InternetConnectionStatus currentStatus = await connectionStatus;

    if (_lastStatus != currentStatus && _statusController.hasListener) {
      _statusController.add(currentStatus);
    }

    if (!_statusController.hasListener) return;
    _timerHandle = Timer(checkInterval, _maybeEmitStatusUpdate);

    _lastStatus = currentStatus;
  }

  InternetConnectionStatus? _lastStatus;
  Timer? _timerHandle;

  // controller for the exposed 'onStatusChange' Stream
  final StreamController<InternetConnectionStatus> _statusController =
  StreamController<InternetConnectionStatus>.broadcast();


  Stream<InternetConnectionStatus> get onStatusChange =>
      _statusController.stream;

  bool get hasListeners => _statusController.hasListener;

  bool get isActivelyChecking => _statusController.hasListener;
}
