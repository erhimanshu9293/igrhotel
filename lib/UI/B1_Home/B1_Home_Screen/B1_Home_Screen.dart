import 'dart:async';

import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/Anaheim.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/Florida.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/LasVegas.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/LosAngels.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/NewYork.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Recommendation/RecommendationDetailScreen.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Vocation/Mountains.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Vocation/Sun.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Vocation/Tropical.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Vocation/beaches.dart';
import 'package:booking_hotel_firebase/UI/Search/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';

import 'Promo_Detail_Information.dart';
import 'editProfile.dart';

class Home extends StatefulWidget {
  final String userID;
  Home({this.userID});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loadImage = true;
  bool loadData = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 3500), () {
      setState(() {
        loadData = false;
      });
    });
    Timer(Duration(milliseconds: 4500), () {
      setState(() {
        loadImage = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  static final _txtStyle = TextStyle(
      fontSize: 15.5,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Gotik');

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    var _appBar = AppBar(
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context).tr('home'),
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: "Gotik",
              fontSize: 28.0,
              color: Colors.black)),
      centerTitle: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () {},
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  var userDocument = snapshot.data;
                  return Stack(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 0.0, top: 9.0, left: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new updateProfile(
                                      name: userDocument["name"],
                                      uid: widget.userID,
                                      photoProfile:
                                          userDocument["photoProfile"],
                                    ),
                                transitionDuration: Duration(milliseconds: 600),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                }));
                          },
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                                image: DecorationImage(
                                    image: NetworkImage(userDocument[
                                                "photoProfile"] !=
                                            null
                                        ? userDocument["photoProfile"]
                                        : "https://thumbs.dreamstime.com/b/seamless-loopable-abstract-chess-png-grid-pattern-background-gray-squares-white-vector-130526229.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        )),
                  ]);
                }),
          ),
        )
      ],
      elevation: 0.0,
    );

    var _searchBox = Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new Search(
            userId: widget.userID,
          ),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        )),
        child: Container(
          height: 43.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 3.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Color(0xFF09314F),
                  size: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(AppLocalizations.of(context).tr('findDoYouWant'),
                      style: TextStyle(
                          color: Colors.black26,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Future getCarouselWidget() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore.collection("promotionBanner").get();
      return qn.docs;
    }

    var _sliderImage = Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 190,
          aspectRatio: 24 / 18,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [0, 1, 2, 3, 4].map((i) {
          return FutureBuilder(
              future: getCarouselWidget(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');

                if (!snapshot.hasData) {
                  return new Container(
                    height: 190.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/be/17/88/be17880995d36aed7fab5679d01faa00.jpg"),
                            fit: BoxFit.cover)),
                  );
                } else {
                  String image = snapshot.data[i].data()['image'].toString();
                  List<String> description =
                      List.from(snapshot.data[i].data()['description']);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => PromoDetailInformation(
                                image: image,
                                description: description,
                              )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 9.0,
                                spreadRadius: 8.0,
                                color: Colors.black12.withOpacity(0.05))
                          ],
                          image: DecorationImage(
                              image: NetworkImage(loadImage
                                  ? "https://images2.imgbox.com/a9/7e/JkiFnCo3_o.png"
                                  : snapshot.data[i].data()["image"]),
                              fit: BoxFit.cover),
                          color: Color(0xFF23252E)),
                    ),
                  );
                }
              });
        }).toList(),
      ),
    );

    var _recomendedbookitngo = Container(
      padding: EdgeInsets.only(top: 40.0),
      height: 350.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
            child: Text(
              AppLocalizations.of(context).tr('recommended'),
              style: _txtStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
              height: 250.0,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("recommendedCard")
                    .snapshots(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Container(
                      height: 260.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images2.imgbox.com/a9/7e/JkiFnCo3_o.png"))),
                    );
                  }
                  return snapshot.hasData
                      ? new cardSuggeted(
                          dataUser: widget.userID,
                          list: snapshot.data.docs,
                        )
                      : Container(
                          height: 10.0,
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );

    var _destinationPopuler = Container(
      padding: EdgeInsets.only(top: 30.0),
      height: 287.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('popularDestination'),
                    style: _txtStyle,
                  ),
                  // Text(
                  //   AppLocalizations.of(context).tr('seeMore'),
                  //   style: _txtStyle.copyWith(
                  //       color: Colors.black26, fontSize: 13.5),
                  // )
                ],
              )),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Anaheim(
                              title: AppLocalizations.of(context).tr('anaheim'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardDestinationPopuler(
                    txt: AppLocalizations.of(context).tr('anaheim'),
                    img:
                        'https://images.pexels.com/photos/374870/pexels-photo-374870.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new LosAngeles(
                              title:
                                  AppLocalizations.of(context).tr('losAngeles'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardDestinationPopuler(
                    txt: AppLocalizations.of(context).tr('losAngeles'),
                    img:
                        'https://images.pexels.com/photos/373912/pexels-photo-373912.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Florida(
                              title: AppLocalizations.of(context).tr('florida'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardDestinationPopuler(
                    txt: AppLocalizations.of(context).tr('florida'),
                    img:
                        'https://images.pexels.com/photos/3643461/pexels-photo-3643461.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new LasVegas(
                              title:
                                  AppLocalizations.of(context).tr('lasVegas'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardDestinationPopuler(
                    txt: AppLocalizations.of(context).tr('lasVegas'),
                    img:
                        'https://images.pexels.com/photos/2837909/pexels-photo-2837909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new NewYork(
                              title: AppLocalizations.of(context).tr('newYork'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardDestinationPopuler(
                    txt: AppLocalizations.of(context).tr('newYork'),
                    img:
                        'https://images.pexels.com/photos/2190283/pexels-photo-2190283.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var _vacations = Container(
      padding: EdgeInsets.only(top: 20.0),
      height: 177.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('vacations'),
                    style: _txtStyle,
                  ),
                  Text(
                    "",
                    style: _txtStyle.copyWith(
                        color: Colors.black26, fontSize: 13.5),
                  )
                ],
              )),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Beaches(
                              title: AppLocalizations.of(context).tr('beaches'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardVacations(
                    txt: AppLocalizations.of(context).tr('beaches'),
                    desc: AppLocalizations.of(context).tr('descBeaches'),
                    img: 'assets/image/icon/beach.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Mountains(
                              title:
                                  AppLocalizations.of(context).tr('mountains'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardVacations(
                    txt: AppLocalizations.of(context).tr('mountains'),
                    desc: AppLocalizations.of(context).tr('descMountains'),
                    img: 'assets/image/icon/mountain.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Sun(
                              title: AppLocalizations.of(context).tr('sun'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardVacations(
                    txt: AppLocalizations.of(context).tr('sun'),
                    desc: AppLocalizations.of(context).tr('detaileSun'),
                    img: 'assets/image/icon/sun.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Tropical(
                              title:
                                  AppLocalizations.of(context).tr('tropical'),
                              userId: widget.userID,
                            ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: cardVacations(
                    txt: AppLocalizations.of(context).tr('tropical'),
                    desc: AppLocalizations.of(context).tr('descTropical'),
                    img: 'assets/image/icon/tropical.png',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    ///  Grid item in bottom of Category
    var _recommendedRooms = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
              child: Text(AppLocalizations.of(context).tr('recommendedRoom'),
                  style: _txtStyle),
            ),

            /// To set GridView item
            ///
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("hotel")
                  .where('type', isEqualTo: 'recommended')
                  .snapshots(),
              builder:
                  (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return new Container(
                    height: 190.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images2.imgbox.com/a9/7e/JkiFnCo3_o.png"))),
                  );
                }
                List<DocumentSnapshot> list = snapshot.data.docs;

                return snapshot.hasData
                    ? new GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.795, crossAxisCount: 2),
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        primary: false,
                        itemBuilder: (BuildContext context, int i) {
                          List<String> photo =
                              List.from(list[i].data()['photo']);
                          List<String> service =
                              List.from(list[i].data()['service']);
                          List<String> description =
                              List.from(list[i].data()['description']);
                          String title = list[i].data()['title'].toString();
                          String type = list[i].data()['type'].toString();
                          num rating = list[i].data()['rating'];
                          String location =
                              list[i].data()['location'].toString();
                          String image = list[i].data()['image'].toString();
                          String id = list[i].data()['id'].toString();
                          num price = list[i].data()['price'];
                          num latLang1 = list[i].data()['latLang1'];
                          num latLang2 = list[i].data()['latLang2'];

                          return EasyLocalizationProvider(
                            data: data,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new hotelDetail2(
                                            userId: widget.userID,
                                            titleD: title,
                                            idD: id,
                                            imageD: image,
                                            latLang1D: latLang1,
                                            latLang2D: latLang2,
                                            locationD: location,
                                            priceD: price,
                                            descriptionD: description,
                                            photoD: photo,
                                            ratingD: rating,
                                            serviceD: service,
                                            typeD: type,
                                          ),
                                      transitionDuration:
                                          Duration(milliseconds: 600),
                                      transitionsBuilder: (_,
                                          Animation<double> animation,
                                          __,
                                          Widget child) {
                                        return Opacity(
                                          opacity: animation.value,
                                          child: child,
                                        );
                                      }));
                                },
                                child: Container(
                                  height: 1000.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF656565)
                                              .withOpacity(0.15),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          //           offset: Offset(4.0, 10.0)
                                        )
                                      ]),
                                  child: Wrap(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Hero(
                                            tag: 'hero-tag-${id}',
                                            child: Material(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5.8,
                                                width: 200.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    7.0),
                                                            topRight: Radius
                                                                .circular(7.0)),
                                                    image: DecorationImage(
                                                        image:
                                                            NetworkImage(image),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Container(
                                              width: 130.0,
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                    letterSpacing: 0.5,
                                                    color: Colors.black54,
                                                    fontFamily: "Sans",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13.0),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 2.0)),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 0.0),
                                                child: Text(
                                                  price.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: "Gotik",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)
                                                    .tr('night'),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: "Gotik",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.0),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 15.0,
                                                top: 5.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    ratingbar(
                                                      starRating: rating,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0),
                                                      child: Text(
                                                        rating.toString(),
                                                        style: TextStyle(
                                                            fontFamily: "Sans",
                                                            color:
                                                                Colors.black26,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : Container(
                        height: 10.0,
                      );
              },
            ),
          ],
        ),
      ),
    );

    var featured = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Text(
            AppLocalizations.of(context).tr('featured'),
            style: _txtStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Container(
            height: 195.0,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("hotel")
                  .where('type', isEqualTo: 'popular')
                  .snapshots(),
              builder:
                  (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return new Container(
                    height: 190.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images2.imgbox.com/a9/7e/JkiFnCo3_o.png"))),
                  );
                }
                return snapshot.hasData
                    ? new cardLastActivity(
                        dataUser: widget.userID,
                        list: snapshot.data.docs,
                      )
                    : Container(
                        height: 10.0,
                      );
              },
            ),
          ),
        )
      ],
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _searchBox,
                        _sliderImage,
                        _vacations,
                        _recomendedbookitngo,
                        _destinationPopuler,
                        featured,
                        _recommendedRooms
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cardLastActivity extends StatelessWidget {
  final String dataUser;
  final List<DocumentSnapshot> list;

  cardLastActivity({
    this.dataUser,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> photo = List.from(list[i].data()['photo']);
          List<String> service = List.from(list[i].data()['service']);
          List<String> description = List.from(list[i].data()['description']);
          String title = list[i].data()['title'].toString();
          String type = list[i].data()['type'].toString();
          num rating = list[i].data()['rating'];
          String location = list[i].data()['location'].toString();
          String image = list[i].data()['image'].toString();
          String id = list[i].data()['id'].toString();
          num price = list[i].data()['price'];
          num latLang1 = list[i].data()['latLang1'];
          num latLang2 = list[i].data()['latLang2'];

          return Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new hotelDetail2(
                          userId: dataUser,
                          titleD: title,
                          idD: id,
                          imageD: image,
                          latLang1D: latLang1,
                          latLang2D: latLang2,
                          locationD: location,
                          priceD: price,
                          descriptionD: description,
                          photoD: photo,
                          ratingD: rating,
                          serviceD: service,
                          typeD: type,
                        ),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      )
                    ]),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Hero(
                          tag: 'hero-tag-${id}',
                          child: Material(
                            child: Container(
                              height: 100.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            width: 110.0,
                            child: Text(
                              title,
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  color: Colors.black54,
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 2.0)),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 0.0),
                              child: Text(
                                "\$ " + price.toString(),
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('night'),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 15.0, top: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: rating,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      rating.toString(),
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          color: Colors.black26,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class cardSuggeted extends StatelessWidget {
  final String dataUser;
  final List<DocumentSnapshot> list;
  cardSuggeted({
    this.dataUser,
    this.list,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          String title = list[i].data()['title'].toString();
          String image = list[i].data()['image'].toString();
          String textImage = list[i].data()['textImage'].toString();
          String desc = list[i].data()['desc'].toString();
          String key = list[i].data()['key'].toString();

          return Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 12.0, top: 8.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new RecommendedDetail(
                              keyID: key,
                              title: title,
                              userId: dataUser,
                            )));
                  },
                  child: Container(
                    width: 285.0,
                    height: 135.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF656565).withOpacity(0.15),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        textImage,
                        style: TextStyle(
                            fontFamily: 'Amira',
                            color: Colors.white,
                            fontSize: 40.0,
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 2.0,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Sans",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                  child: Container(
                      width: 270.0,
                      child: Text(
                        desc,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: "Sans",
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black26,
                        ),
                      )),
                ),
              ],
            ),
          );
        });
  }
}

class cardVacations extends StatelessWidget {
  final String img, txt, desc;
  cardVacations({this.img, this.txt, this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70.0,
            width: 70.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.04),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ],
              image: DecorationImage(
                image: AssetImage(
                  img,
                ),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              border: Border.all(color: Colors.grey[300], width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                txt,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Sofia",
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class cardDestinationPopuler extends StatelessWidget {
  final String img, txt;
  cardDestinationPopuler({this.img, this.txt});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400.0,
        width: 140.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 2.0,
                  spreadRadius: 1.0)
            ]),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                fontFamily: 'Amira',
                color: Colors.white,
                fontSize: 32.0,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                  )
                ]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatelessWidget {
  final String dataUser;
  final List<DocumentSnapshot> list;

  ItemGrid({
    this.dataUser,
    this.list,
  });

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> photo = List.from(list[i].data()['photo']);
          List<String> service = List.from(list[i].data()['service']);
          List<String> description = List.from(list[i].data()['description']);
          String title = list[i].data()['title'].toString();
          String type = list[i].data()['type'].toString();
          num rating = list[i].data()['rating'];
          String location = list[i].data()['location'].toString();
          String image = list[i].data()['image'].toString();
          String id = list[i].data()['id'].toString();
          num price = list[i].data()['price'];
          num latLang1 = list[i].data()['latLang1'];
          num latLang2 = list[i].data()['latLang2'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new hotelDetail2(
                          userId: dataUser,
                          titleD: title,
                          idD: id,
                          imageD: image,
                          latLang1D: latLang1,
                          latLang2D: latLang2,
                          locationD: location,
                          priceD: price,
                          descriptionD: description,
                          photoD: photo,
                          ratingD: rating,
                          serviceD: service,
                          typeD: type,
                        ),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      )
                    ]),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Hero(
                          tag: 'hero-tag-${id}',
                          child: Material(
                            child: Container(
                              height: mediaQueryData.size.height / 5.8,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            width: 130.0,
                            child: Text(
                              title,
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  color: Colors.black54,
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 2.0)),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 0.0),
                              child: Text(
                                price.toString(),
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('night'),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 15.0, top: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: rating,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      rating.toString(),
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          color: Colors.black26,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
