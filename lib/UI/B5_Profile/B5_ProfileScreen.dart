import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/B1_Home_Screen/editProfile.dart';
import 'package:booking_hotel_firebase/UI/IntroApps/onBoardingVideo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ListProfile/CallCenter.dart';
import 'ListProfile/CreditCard.dart';
import 'ListProfile/LanguageScreen.dart';

class profile extends StatefulWidget {
  final String userID;
  profile({this.userID});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  ///
  /// Function for if user logout all preferences can be deleted
  ///
  _delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  _launchURL() async {
    const url = 'https://codecanyon.net/user/qubicletechagency';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Stack(children: <Widget>[
                        Container(
                          height: 352.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/image/images/bannerProfile.png",
                                  ),
                                  fit: BoxFit.cover)),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 67.0, left: 20.0, right: 20.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 90.0,
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://images.pexels.com/photos/1051075/pexels-photo-1051075.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                                              fit: BoxFit.cover),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 10.0,
                                                spreadRadius: 2.0)
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, top: 20.0, right: 20.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .tr('userName'),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Sofia",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20.0),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .tr('userGmail'),
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontFamily: "Sofia",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 16.0),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ]),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ]);
                    }
                    var userDocument = snapshot.data;
                    var string = userDocument["name"];

                    String getInitials({String string, int limitTo}) {
                      var buffer = StringBuffer();
                      var split = string.split(' ');
                      for (var i = 0; i < (limitTo ?? split.length); i++) {
                        buffer.write(split[i][0] ?? "");
                      }

                      return buffer.toString();
                    }

                    return Stack(children: <Widget>[
                      Container(
                        height: 352.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/image/images/bannerProfile.png",
                                ),
                                fit: BoxFit.cover)),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 67.0, left: 20.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 90.0,
                                    width: 90.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(userDocument[
                                                        "photoProfile"] !=
                                                    null
                                                ? userDocument["photoProfile"]
                                                : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                            fit: BoxFit.cover),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12
                                                  .withOpacity(0.1),
                                              blurRadius: 10.0,
                                              spreadRadius: 2.0)
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 20.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            userDocument["name"] != null
                                                ? userDocument["name"]
                                                : AppLocalizations.of(context)
                                                    .tr('name'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            userDocument["email"] != null
                                                ? userDocument["email"]
                                                : AppLocalizations.of(context)
                                                    .tr('email'),
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16.0),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ]),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 300.0),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new updateProfile(
                                          name: userDocument["name"],
                                          uid: widget.userID,
                                          photoProfile:
                                              userDocument["photoProfile"],
                                        )));
                              },
                              child: category(
                                txt: AppLocalizations.of(context)
                                    .tr('editProfile'),
                                image: "assets/image/icon/profile.png",
                                padding: 20.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new addCreditCard(
                                          name: userDocument["name"],
                                          email: userDocument["email"],
                                          password: userDocument["password"],
                                          uid: widget.userID,
                                          photoProfile:
                                              userDocument["photoProfile"],
                                        )));
                              },
                              child: category(
                                txt: AppLocalizations.of(context)
                                    .tr('creditCard'),
                                image: "assets/image/icon/card.png",
                                padding: 20.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new callCenter()));
                              },
                              child: category(
                                txt: AppLocalizations.of(context)
                                    .tr('callCenter'),
                                image: "assets/image/icon/callCenter.png",
                                padding: 20.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new LanguageScreen()));
                              },
                              child: category(
                                txt: AppLocalizations.of(context)
                                    .tr('changeLanguage'),
                                image: "assets/image/icon/language.png",
                                padding: 20.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL();
                              },
                              child: category(
                                txt: AppLocalizations.of(context).tr('aboutUs'),
                                image: "assets/image/icon/box.png",
                                padding: 20.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _delete();
                                FirebaseAuth.instance.signOut().then((result) =>
                                    Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                            pageBuilder: (_, ___, ____) =>
                                                new introVideo())));
                              },
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.0),
                                              child: Icon(
                                                Icons.login,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .tr('logout'),
                                                style: TextStyle(
                                                  fontSize: 14.5,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Sofia",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black26,
                                            size: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ]);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  final String txt, image;
  final GestureTapCallback tap;
  final double padding;

  category({this.txt, this.image, this.tap, this.padding});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: Image.asset(
                        image,
                        height: 25.0,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
