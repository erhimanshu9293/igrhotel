import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key key}) : super(key: key);

  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context).tr('language'),
            style: TextStyle(
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5,
                letterSpacing: 1.2,
                color: Colors.black87),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => NetworkGiffyDialog(
                                image: Image.asset(
                                  "assets/image/earth.gif",
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                    AppLocalizations.of(context)
                                        .tr('titleCard'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600)),
                                description: Text(
                                  AppLocalizations.of(context).tr('descCard'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black26),
                                ),
                                onOkButtonPressed: () {
                                  data.changeLocale(Locale('en', 'US'));
                                  Navigator.pop(context);
                                },
                              ));
                    },
                    child: cardName(
                      flag:
                          "https://cdn-icons-png.flaticon.com/512/330/330459.png",
                      title: AppLocalizations.of(context).tr('english'),
                    )),
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => NetworkGiffyDialog(
                                image: Image.asset(
                                  "assets/image/earth.gif",
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                    AppLocalizations.of(context)
                                        .tr('titleCard'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600)),
                                description: Text(
                                  AppLocalizations.of(context).tr('descCard'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black26),
                                ),
                                onOkButtonPressed: () {
                                  data.changeLocale(Locale('ar', 'DZ'));
                                  Navigator.pop(context);
                                },
                              ));
                    },
                    child: cardName(
                      flag:
                          "https://cdn-icons-png.flaticon.com/512/330/330534.png",
                      title: AppLocalizations.of(context).tr('arabic'),
                    )),
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => NetworkGiffyDialog(
                                image: Image.asset(
                                  "assets/image/earth.gif",
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                    AppLocalizations.of(context)
                                        .tr('titleCard'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600)),
                                description: Text(
                                  AppLocalizations.of(context).tr('descCard'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black26),
                                ),
                                onOkButtonPressed: () {
                                  data.changeLocale(Locale('zh', 'CN'));
                                  Navigator.pop(context);
                                },
                              ));
                    },
                    child: cardName(
                      flag: "https://images2.imgbox.com/b6/73/EZpBm2U0_o.png",
                      title: AppLocalizations.of(context).tr('chinese'),
                    )),
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => NetworkGiffyDialog(
                                image: Image.asset(
                                  "assets/image/earth.gif",
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                    AppLocalizations.of(context)
                                        .tr('titleCard'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600)),
                                description: Text(
                                  AppLocalizations.of(context).tr('descCard'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black26),
                                ),
                                onOkButtonPressed: () {
                                  data.changeLocale(Locale('hi', 'IN'));
                                  Navigator.pop(context);
                                },
                              ));
                    },
                    child: cardName(
                      flag: "https://images2.imgbox.com/d6/28/7rRTBLIz_o.png",
                      title: AppLocalizations.of(context).tr('indian'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cardName extends StatelessWidget {
  final String title, flag;
  cardName({this.title, this.flag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 0.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 15.0),
          child: Row(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image.network(
                flag,
                height: 68.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: "Popins",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
