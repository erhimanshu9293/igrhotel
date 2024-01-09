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
import 'package:booking_hotel_firebase/UI/IntroApps/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  bool isLoading = false;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _name,_mobile;
  var profilePicUrl;
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupMobileController = new TextEditingController();

  // TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  var tap = 0;

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

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
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
            : Form(
                key: _registerFormKey,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// Image Top
                            Container(
                              height: 220,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    height: 270,
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
                                  FadeAnimation(
                                      1.2,
                                      Text(
                                        AppLocalizations.of(context)
                                            .tr('register'),
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
                                                        .tr('inputName');
                                                  }
                                                },
                                                onSaved: (input) =>
                                                    _name = input,
                                                controller:
                                                    signupNameController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        AppLocalizations.of(
                                                                context)
                                                            .tr('userName'),
                                                    icon: Icon(
                                                      Icons.person,
                                                      color: Colors.black12,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "sofia")),
                                              ),
                                            ),
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
                                                        .tr('pleaseEmail');
                                                  }
                                                },
                                                onSaved: (input) =>
                                                    _email = input,
                                                controller:
                                                    signupEmailController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        AppLocalizations.of(
                                                                context)
                                                            .tr('email'),
                                                    icon: Icon(
                                                      Icons.email,
                                                      color: Colors.black12,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "sofia")),
                                              ),
                                            ),
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
                                                controller:
                                                signupMobileController,
                                                keyboardType: TextInputType.number,
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
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                      1.7,
                                      InkWell(
                                          onTap: () async {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                Login(),
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
                                                .tr('haveAccount'),
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1.3),
                                          ))),
                                  SizedBox(
                                    height: 90,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        /// Set Animaion after user click buttonSignup
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
                                    prefs.setString("mobile", _name);
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
                                  } catch (e) {
                                    print(e.message);
                                    print(_email);
                                    print(_name);
                                    print(_mobile);
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
                                    AppLocalizations.of(context).tr('register'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.5,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
