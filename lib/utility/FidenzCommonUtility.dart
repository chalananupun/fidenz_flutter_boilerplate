import 'package:fidenz_flutter_boilerplate/utility/url_launch/LaunchMode.dart';
import 'package:fidenz_flutter_boilerplate/utility/url_launch/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FidenzCommonUtility{

  static void startScreen(BuildContext context,Widget widget){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
          return  widget;
        }));
  }


  static void endScreen(BuildContext context){
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }


  static openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

  static openBrowser(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $link');
    }
  }

  static openMap(double lat, double lng) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Unable open the map.';
    }
  }

}