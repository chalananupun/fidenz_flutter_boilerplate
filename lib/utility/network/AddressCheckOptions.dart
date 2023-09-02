import 'dart:io';
import 'package:fidenz_flutter_boilerplate/utility/network/InternetConnectionChecker.dart';

class AddressCheckOptions {
  /// [AddressCheckOptions] Constructor
  AddressCheckOptions(
      this.address, {
        this.port = InternetConnectionChecker.DEFAULT_PORT,
        this.timeout = InternetConnectionChecker.DEFAULT_TIMEOUT,
      });


  final InternetAddress address;

  /// Port
  final int port;

  /// Timeout Duration
  final Duration timeout;

  @override
  String toString() => 'AddressCheckOptions($address, $port, $timeout)';
}
