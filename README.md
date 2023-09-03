
Fidenz Flutter Boilerplate

## Features
Built in :

* Check connectivity status
* Device functions 
* Logger
* Local storage with key/value pair

## Getting started
Fidenz Flutter Boilerplate

The Fidenz Flutter Boilerplate is a powerful and feature-rich starting template for Flutter app development.
It provides a solid foundation and various pre-built functions to simplify the development process and accelerate the creation of high-quality Flutter applications.

## Usage

Network Utility :
 - Check network status
```dart
 FidenzNetworkUtility.getNetworkStatus((isOnline) => {
// do your task here
});
```

Common Utility :
 - Send contact number to dial pad :
```dart
FidenzCommonUtility.openDialPad("0716359376");
```

- Send url to default browser :
```dart
FidenzCommonUtility.openBrowser("https://www.youtube.com");
```

- Send location to map :
```dart
FidenzCommonUtility.openMap(6.8844532771946065, 79.88681071160158);
```

- Start screen :
```dart
FidenzCommonUtility.startScreen(context, LogoutScreen());
```

- End screen :
```dart
FidenzCommonUtility.endScreen(context);
```

Log Utility :
- log :
```dart
FidenzLogUtility.log("TAG ::: FCM TOKEN : $token");
```

Device Utility :
- get Screen width :
```dart
    var screenWidth = FidenzDeviceUtility.getWidth(context);
```

- get Screen height :
```dart
       var screenHeight = FidenzDeviceUtility.getHeight(context);
```

- Enter full screen mode :
```dart
       FidenzDeviceUtility.enterFullScreenMode();
```

- Exit full screen mode :
```dart
       FidenzDeviceUtility.exitFullScreenMode();
```

- Hide soft keyboard :
```dart
       FidenzDeviceUtility.hideSoftKeyBoard(context);
```

- Lock portrait mode :
```dart
      FidenzDeviceUtility.lockAutoRotate();
```

- Control screen support orientation modes :
```dart
      FidenzDeviceUtility.setScreenOrientation([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft]);
```


Shared Preference Utility :
- Store data in local storage :
```dart
FidenzSharedPreferenceUtility.setData(DataType.string, "FCM_TOKEN", "ABC123");
```

- Retrieve data from local storage :
```dart
var token = FidenzSharedPreferenceUtility.getStringData("FCM_TOKEN");
var isUserLogged = FidenzSharedPreferenceUtility.getBoolData("IS_USER_LOGGED");
var age = FidenzSharedPreferenceUtility.getIntData("USER_AGE");
```

## Additional information
"This was crafted by Chalana Nipun at Fidenz Technologies in 2023."





