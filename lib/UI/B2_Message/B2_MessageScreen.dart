import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/UI/B2_Message/ChatBot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class noMessage extends StatefulWidget {
  final String userID;
  noMessage({this.userID});

  @override
  _noMessageState createState() => _noMessageState();
}

class _noMessageState extends State<noMessage> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    double _height = MediaQuery.of(context).size.height;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('chat'),
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 29.5,
                wordSpacing: 0.1),
          ),
          actions: <Widget>[],
        ),
        body: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Stack(children: <Widget>[]);
                  }
                  var userDocument = snapshot.data;
                  var string = userDocument["name"];

                  String getInitials({String string, int limitTo}) {
                    var buffer = StringBuffer();
                    var split = string.split(' ');
                    for (var i = 0; i < (limitTo ?? split.length); i++) {
                      buffer.write(split[i][0]);
                    }

                    return buffer.toString();
                  }

                  var output = getInitials(string: string);

                  return Stack(
                    children: [
                      Image.asset(
                        "assets/image/destinationPopuler/destination1.png",
                        height: _height,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 210.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20.0,
                                      color: Colors.black12.withOpacity(0.08))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13.0, bottom: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context).tr('bookItGo'),
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        fontSize: 23.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Text(
                                    AppLocalizations.of(context).tr('descBot'),
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontFamily: "Sofia",
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            chatBot()));
                                  },
                                  child: Container(
                                    height: 45.0,
                                    width: 180.0,
                                    color: Color(0xFF09314F),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .tr('startChatting'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Sofia"),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
