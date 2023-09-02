
import 'AddressCheckOptions.dart';

class AddressCheckResult {
  /// [AddressCheckResult] constructor
  AddressCheckResult(
      this.options,
      this.isSuccess,
      );

  /// AddressCheckOptions
  final AddressCheckOptions options;

  /// bool val to store result
  final bool isSuccess;

  @override
  String toString() => 'AddressCheckResult($options, $isSuccess)';
}
