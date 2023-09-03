import 'package:fidenz_flutter_boilerplate/example.dart';
import 'package:fidenz_flutter_boilerplate/fidenz_flutter_boilerplate.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {


    FidenzDeviceUtility.lockAutoRotate();

    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: "Example",
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.15);
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
          );
        },
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: Example(),
        );
  }


}