import 'package:flutter/material.dart';
import 'package:netflux/const.dart';
import 'package:netflux/screens/splash/splash_screen.dart';
import 'routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: applicationName,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: mainFont),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
