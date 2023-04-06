import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:photo_viewer/screens/home_page.dart';
//import 'package:amplify_auth_cognito_ios/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add Plugins
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyStorageS3 storagePlugin = AmplifyStorageS3();

    await Amplify.addPlugins([
      authPlugin,
      storagePlugin,
    ]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child:
        MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        // `builder` must be specified with `Authenticator.builder()`.
        builder: Authenticator.builder(),

        // You can use any combination of `routes`, `home`,
        // `onGenerateRoute`, etc. as long as `builder` is
        // configured as shown above.
        home: HomePage(),
      ),);

  }
}
