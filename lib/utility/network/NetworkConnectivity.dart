import 'dart:async';

import 'InternetConnectionChecker.dart';
import 'InternetConnectionStatus.dart';

class NetworkConnectivity {
  static late StreamSubscription<InternetConnectionStatus> connectivityListener;
  static bool isConnectionReady = false;

  static init() {
    connectivityListener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isConnectionReady = true;
          break;
        case InternetConnectionStatus.disconnected:
          isConnectionReady = false;
          break;
      }
    });
  }

  static dispose() async {
    await connectivityListener.cancel();
  }

  static Future<bool> isNetworkAvailable() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}