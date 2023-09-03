import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FidenzDeviceUtility {
  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static hideSoftKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static enterFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static exitFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  static setScreenOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  static lockAutoRotate() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }


}
