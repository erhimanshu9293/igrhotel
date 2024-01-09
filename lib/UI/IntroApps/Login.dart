// ignore_for_file: deprecated_member_use

import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/Library/loader_animation/dot.dart';
import 'package:booking_hotel_firebase/Library/loader_animation/loader.dart';
import 'package:booking_hotel_firebase/UI/IntroApps/OtpVerify.dart';
import 'package:booking_hotel_firebase/UI/IntroApps/travelSelection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel_firebase/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;

  var tap = 0;

  bool isLoading = false;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _mobile, _email, _pass, _id;

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
                                            .tr('login'),
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
                                              child: TextFormField(
                                                // ignore: missing_return
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)
                                                        .tr('pleaseMobile');
                                                  }
                                                },
                                                onSaved: (input) =>
                                                _mobile = input,
                                                keyboardType: TextInputType.number,

                                                controller:
                                                    loginEmailController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        AppLocalizations.of(
                                                                context)
                                                            .tr('inputMobile'),

                                                    icon: Icon(
                                                      Icons.phone_android,
                                                      color: Colors.black12,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "sofia")),
                                              ),
                                            ),

                                            // Container(
                                            //   padding: EdgeInsets.all(10),
                                            //   child: TextFormField(
                                            //     // ignore: missing_return
                                            //     validator: (input) {
                                            //       if (input.isEmpty) {
                                            //         return AppLocalizations.of(
                                            //                 context)
                                            //             .tr('typePassword');
                                            //       }
                                            //     },
                                            //     onSaved: (input) =>
                                            //         _pass = input,
                                            //     controller:
                                            //         loginPasswordController,
                                            //     obscureText: true,
                                            //     decoration: InputDecoration(
                                            //         border: InputBorder.none,
                                            //         hintText:
                                            //             AppLocalizations.of(
                                            //                     context)
                                            //                 .tr('password'),
                                            //         icon: Icon(
                                            //           Icons.vpn_key,
                                            //           color: Colors.black12,
                                            //         ),
                                            //         hintStyle: TextStyle(
                                            //             color: Colors.grey,
                                            //             fontFamily: "sofia")),
                                            //   ),
                                            // )

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
                                                .tr('createAccount'),
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
                                User user;
                                if (formState.validate()) {
                                  formState.save();
                                  try {
                                    prefs.setString("mobile", _mobile);
                                    // prefs.setString("id", _id);
                                    Navigator.of(context)
                                        .pushReplacement(
                                        PageRouteBuilder(
                                            pageBuilder:
                                                (_, __, ___) =>
                                                OtpVerifyScreen(),
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
                                    // user.sendEmailVerification();

                                  } catch (e) {
                                    print('Error: $e');
                                    CircularProgressIndicator();
                                    print(e.message);
                                    print(_mobile);

                                    print(_pass);
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              AppLocalizations.of(context)
                                                  .tr('error')),
                                          content: Text(
                                              AppLocalizations.of(context)
                                                  .tr('checkEmailPassword')),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .tr('close')),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }
                                ;
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
                                    AppLocalizations.of(context).tr('signin'),
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
