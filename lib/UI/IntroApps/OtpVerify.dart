// ignore_for_file: deprecated_member_use

import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/Library/loader_animation/dot.dart';
import 'package:booking_hotel_firebase/Library/loader_animation/loader.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:booking_hotel_firebase/UI/IntroApps/travelSelection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel_firebase/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerifyScreen extends StatefulWidget {
  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;

  var tap = 0;

  bool isLoading = false;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _id;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  @override

  /// set state animation controller
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    final width = MediaQuery.of(context).size.width;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: ColorLoader5(
                dotOneColor: Colors.red,
                dotTwoColor: Colors.blueAccent,
                dotThreeColor: Colors.green,
                dotType: DotType.circle,
                dotIcon: Icon(Icons.adjust),
                duration: Duration(seconds: 1),
              ))

            ////
            /// Layout loading
            ///
            : Form(
                key: _registerFormKey,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 270,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    height: 300,
                                    width: width + 20,
                                    child: FadeAnimation(
                                        1.3,
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/image/destinationPopuler/tripBackground.png'),
                                                  fit: BoxFit.fill)),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  /// Fade Animation for transtition animaniton
                                  FadeAnimation(
                                      1.2,
                                      Text(
                                        AppLocalizations.of(context)
                                            .tr('otpverify'),
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 37.5,
                                            wordSpacing: 0.1),
                                      )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  FadeAnimation(
                                      1.7,
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    196, 135, 198, .3),
                                                blurRadius: 20,
                                                offset: Offset(0, 10),
                                              )
                                            ]),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: OtpTextField(
                                                numberOfFields: 5,
                                                borderColor: Color(0xFF512DA8),
                                                //set to true to show as box or false to show as dash
                                                showFieldAsBox: true,
                                                //runs when a code is typed in
                                                onCodeChanged: (String code) {
                                                  //handle validation or checks here
                                                },
                                                //runs when every textfield is filled
                                                onSubmit: (String verificationCode){
                                                  showDialog(
                                                      context: context,
                                                      builder: (context){
                                                        return AlertDialog(
                                                          title: Text("Verification Code"),
                                                          content: Text('Code entered is $verificationCode'),
                                                        );
                                                      }
                                                  );
                                                }, // end onSubmit
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                      1.7,
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                Signup(),
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    2000),
                                                        transitionsBuilder: (_,
                                                            Animation<double>
                                                                animation,
                                                            __,
                                                            Widget child) {
                                                          return Opacity(
                                                            opacity:
                                                                animation.value,
                                                            child: child,
                                                          );
                                                        }));
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .tr('resendotp'),
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1.3),
                                          ))),
                                  SizedBox(height: 110)
                                ],
                              ),
                            ),
                          ],
                        ),
                        FadeAnimation(
                            1.9,
                            InkWell(
                              onTap: () async {
                                SharedPreferences prefs;
                                prefs = await SharedPreferences.getInstance();
                                final formState = _registerFormKey.currentState;
                                if (formState.validate()) {
                                  formState.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    // prefs.setString("mobile", _name);
                                    Navigator.of(context)
                                        .pushReplacement(
                                        PageRouteBuilder(
                                            pageBuilder:
                                                (_, __, ___) =>
                                                Home(),
                                            transitionDuration:
                                            Duration(
                                                milliseconds:
                                                2000),
                                            transitionsBuilder: (_,
                                                Animation<double>
                                                animation,
                                                __,
                                                Widget child) {
                                              return Opacity(
                                                opacity:
                                                animation.value,
                                                child: child,
                                              );
                                            }));
                                  } catch (e) {
                                    print(e.message);
                                    // print(_email);
                                  }
                                } else {
                                }
                              },
                              child: Container(
                                height: 55.0,
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xFF8DA2BF),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context).tr('verify'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.5,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
