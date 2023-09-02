import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NetworkConnectivity.dart';

class FidenzNetworkUtility{

  static late FidenzNetworkUtility instance;

  static FidenzNetworkUtility init(){
    instance ??= FidenzNetworkUtility();
    return instance;
  }

  void getNetworkStatus(Function(bool isOnline) callback) {

    NetworkConnectivity.isNetworkAvailable().then((value) {
      callback.call(value);
    });
  }

  void getNetworkStatusWithAlert(Function(bool isOnline) callback,BuildContext context,Widget snackBarWidget,Color backgroundColor) {

    NetworkConnectivity.isNetworkAvailable().then((value) {
      callback.call(value);
      if (!value) {
        showNoInternetSnackBar(context, snackBarWidget,backgroundColor);
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });
  }



  //show no internet error message as SnackBar
  static void showNoInternetSnackBar(
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