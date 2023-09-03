import 'package:fidenz_flutter_boilerplate/fidenz_flutter_boilerplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {

    FidenzNetworkUtility.getNetworkStatus((isOnline) => {
      // do your task
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


    );
  }
}
