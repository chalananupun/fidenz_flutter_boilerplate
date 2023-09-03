import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'network/NetworkConnectivity.dart';

class FidenzNetworkUtility{

  static void getNetworkStatus(Function(bool isOnline) callback) {
    NetworkConnectivity.isNetworkAvailable().then((value) {
      callback.call(value);
    });
  }

  static void getNetworkStatusWithAlert(Function(bool isOnline) callback,BuildContext context,Widget snackBarWidget,Color backgroundColor) {
    NetworkConnectivity.isNetworkAvailable().then((value) {
      callback.call(value);
      if (!value) {
        _showNoInternetSnackBar(context, snackBarWidget,backgroundColor);
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });
  }



  //show no internet error message as SnackBar
  static void _showNoInternetSnackBar(
      BuildContext context,
      Widget widget,Color bgColor
      ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bgColor,
      content: widget,
      duration: const Duration(seconds: 10),
    ));
  }

}