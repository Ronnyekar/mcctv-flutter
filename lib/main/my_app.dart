import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monitoring_cctv/firebase/auth.dart';
import 'package:monitoring_cctv/firebase/wrapper.dart';
import 'package:monitoring_cctv/models/firebaseuser.dart';
import 'package:provider/provider.dart';
import 'package:monitoring_cctv/Pages/login_page.dart';
import 'package:splashscreen/splashscreen.dart';

class MyApp extends StatelessWidget {
  // final FlavorConfig flavorConfig;
  // const MyApp({super.key, required this.flavorConfig});
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.light,
            primaryColor: Colors.blue,
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.black,
              textTheme: ButtonTextTheme.primary,
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.white),
            ),
            fontFamily: 'Georgia',
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14, fontFamily: 'Hind'),
            )),
        home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: Wrapper(),
          image: Image.asset(
            'images/Logo.png',
            height: 250,
            width: 250,
            alignment: Alignment.center,
          ),
          photoSize: 100,
          backgroundColor: Colors.white,
          // backgroundColor: const Color(0xff392850),
          styleTextUnderTheLoader: const TextStyle(),
          loaderColor: Colors.blue,
        ),
      ),
    );
  }
}
