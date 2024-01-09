import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'SearchTagResult.dart';

class searchBoxEmpty extends StatefulWidget {
  final String idUser;
  searchBoxEmpty({Key key, this.idUser}) : super(key: key);

  @override
  _searchBoxEmptyState createState() => _searchBoxEmptyState();
}

class _searchBoxEmptyState extends State<searchBoxEmpty>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Container(
        height: 145.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Text(
                AppLocalizations.of(context).tr('tagsKeywoard'),
                style: TextStyle(
                    fontFamily: "Gotik",
                    color: Colors.black87,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20.0)),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "Anaheim",
                                  type: "location",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                        child: Container(
                          height: 29.5,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.5,
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('anaheim'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontFamily: "Sans"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "beaches",
                                  type: "vacations",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('beaches'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Sans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 9.0,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "mountains",
                                  type: "vacations",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                        child: Container(
                          height: 29.5,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.5,
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('mountains'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontFamily: "Sans"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "sun",
                                  type: "vacations",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('sun'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Sans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 9.0,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "Los Angeles",
                                  type: "location",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                        child: Container(
                          height: 29.5,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.5,
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('losAngeles'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontFamily: "Sans"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "florida",
                                  type: "location",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('florida'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Sans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 9.0,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => SearchTagResult(
                                    data: "tropical",
                                    type: "vacations",
                                    userID: widget.idUser,
                                  )));
                        },
                        child: Container(
                          height: 29.5,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.5,
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('tropical'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontFamily: "Sans"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "Anaheim",
                                  type: "location",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Container(
                        height: 29.5,
                        width: 106.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('sanFrancisco'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Sans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 9.0,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "Las Vegas",
                                  type: "location",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 3.0),
                        child: Container(
                          height: 29.5,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.5,
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('lasVegas'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontFamily: "Sans"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SearchTagResult(
                                  data: "New York",
                                  type: "location",
                                  userID: widget.idUser,
                                )));
                      },
                      child: Container(
                        height: 29.5,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('newYork'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Sans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 9.0,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class CardCountry extends StatelessWidget {
  final Color colorTop, colorBottom;
  final String image, title;
  CardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      child: Container(
        height: 200.0,
        width: 130.0,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
              colors: [colorTop, colorBottom],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Sofia", fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    image,
                    height: 90,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
