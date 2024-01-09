import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel_firebase/UI/IntroApps/OnBoarding.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'UI/Bottom_Nav_Bar/bottomNavBar.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(child: splash()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        home: splashScreen(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          EasylocaLizationDelegate(
            locale: data.locale,
            path: 'lib/Library/Multiple_Language/language',
          )
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
          Locale('ar', 'IQ'),
          Locale('hi', 'IN'),
          Locale('zh', 'CN')
        ],
        locale: data.savedLocale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            primaryColorLight: Colors.white,
            primaryColorBrightness: Brightness.light,
            primaryColor: Colors.white),
      ),
    );
  }
}

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void _Navigator() {
    FirebaseAuth.instance.authStateChanges().listen((User currentUser) {
      if (currentUser == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      if (currentUser == null) {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => onBoarding(),
        ));
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .get()
            .then((DocumentSnapshot result) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => bottomNavBar(
                          userID: currentUser.uid,
                        ))))
            .catchError((err) => print(err));
      }
    });
  }

  /// Set timer splash
  _timer() async {
    return Timer(Duration(milliseconds: 2300), _Navigator);
  }

  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Center(
          child: Image.asset(
            "assets/image/logo/fullLogo.png",
            width: 250.0,
          ),
        ),
      ),
    );
  }
}
