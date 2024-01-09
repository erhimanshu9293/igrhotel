import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/Anaheim.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/Florida.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/LasVegas.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/LosAngels.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Destination/NewYork.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel_firebase/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';

class exploreTrip extends StatefulWidget {
  final String userId;
  exploreTrip({this.userId});

  @override
  _exploreTripState createState() => _exploreTripState();
}

class _exploreTripState extends State<exploreTrip> {
  @override
  Widget build(BuildContext context) {
    Future getCarouselWidget() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore.collection("banner").get();
      return qn.docs;
    }

    var data = EasyLocalizationProvider.of(context).data;
    double _height = MediaQuery.of(context).size.height;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: _height,
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    //      _sliderImage,
                    Container(
                      height: 292.0,
                      child: new Carousel(
                        boxFit: BoxFit.cover,
                        dotColor: Colors.white.withOpacity(0.8),
                        dotSize: 5.5,
                        dotSpacing: 16.0,
                        dotBgColor: Colors.transparent,
                        showIndicator: true,
                        overlayShadow: true,
                        overlayShadowColors: Colors.white.withOpacity(0.9),
                        overlayShadowSize: 0.9,
                        images: [0, 1, 2, 3].map((i) {
                          return FutureBuilder(
                              future: getCarouselWidget(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return new Container(
                                    height: 190.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://images2.imgbox.com/a9/7e/JkiFnCo3_o.png"),
                                            fit: BoxFit.cover)),
                                  );
                                }

                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(0.0, 1.0),
                                        stops: [0.0, 1.0],
                                        colors: <Color>[
                                          Color(0x00FFFFFF),
                                          Color(0xFFFFFFFF),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 9.0,
                                            spreadRadius: 7.0,
                                            color: Colors.black12
                                                .withOpacity(0.03))
                                      ],
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data[i].data["imageBanner"]),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              });
                        }).toList(),
                      ),
                    ),
                    Container(
                      height: 292.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(0.0, 1.0),
                          stops: [0.0, 1.0],
                          colors: <Color>[
                            Color(0x00FFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15.0, right: 15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 15.0),
                  child: Text(
                    AppLocalizations.of(context).tr('discoverNewPlaces'),
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  height: 320.0,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("discover")
                        .snapshots(),
                    builder: (BuildContext ctx,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          ? new card(
                              dataUser: widget.userId,
                              list: snapshot.data.docs,
                            )
                          : Container(
                              height: 10.0,
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).tr('topDestination'),
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          AppLocalizations.of(context).tr('seeAll'),
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Container(
                    height: 142.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new Anaheim(
                                      title: AppLocalizations.of(context)
                                          .tr('anaheim'),
                                      userId: widget.userId,
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
                          child: cardCountry(
                            colorTop: Color(0xFFF07DA4),
                            colorBottom: Color(0xFFF5AE87),
                            image: "assets/image/icon/amerika.png",
                            title: AppLocalizations.of(context).tr('anaheim'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new LosAngeles(
                                      title: 'Los Angeles',
                                      userId: widget.userId,
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
                          child: cardCountry(
                              colorTop: Color(0xFF63CCD1),
                              colorBottom: Color(0xFF75E3AC),
                              image: "assets/image/icon/amerika.png",
                              title: AppLocalizations.of(context)
                                  .tr('losAngeles')),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new Florida(
                                      title: AppLocalizations.of(context)
                                          .tr('florida'),
                                      userId: widget.userId,
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
                          child: cardCountry(
                              colorTop: Color(0xFF9183FC),
                              colorBottom: Color(0xFFDB8EF6),
                              image: "assets/image/icon/amerika.png",
                              title:
                                  AppLocalizations.of(context).tr('florida')),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new LasVegas(
                                      title: AppLocalizations.of(context)
                                          .tr('lasVegas'),
                                      userId: widget.userId,
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
                          child: cardCountry(
                              colorTop: Color(0xFF56AB2F),
                              colorBottom: Color(0xFFA8E063),
                              image: "assets/image/icon/amerika.png",
                              title:
                                  AppLocalizations.of(context).tr('lasVegas')),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new NewYork(
                                      title: AppLocalizations.of(context)
                                          .tr('newYork'),
                                      userId: widget.userId,
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
                          child: cardCountry(
                              colorTop: Color(0xFF74EBD5),
                              colorBottom: Color(0xFFACB6E5),
                              image: "assets/image/icon/amerika.png",
                              title:
                                  AppLocalizations.of(context).tr('newYork')),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, right: 15.0),
                  child: Text(
                    AppLocalizations.of(context).tr('recommended'),
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("hotel")
                        .where('type', isEqualTo: 'recommended')
                        .snapshots(),
                    builder: (BuildContext ctx,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          ? new cardList(
                              dataUser: widget.userId,
                              list: snapshot.data.docs,
                            )
                          : Container(
                              height: 10.0,
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cardList extends StatelessWidget {
  final String dataUser;
  final List<DocumentSnapshot> list;

  final _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  final _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  cardList({
    this.dataUser,
    this.list,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
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
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                height: 250.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  Hero(
                    tag: 'hero-tag-${id}',
                    child: Material(
                      child: Container(
                        height: 165.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                        ),
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 220.0,
                                  child: Text(
                                    title,
                                    style: _txtStyleTitle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: rating,
                                    color: Color(0xFF09314F),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5.0)),
                                  Text(
                                    "(" + rating.toString() + ")",
                                    style: _txtStyleSub,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.9),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 16.0,
                                      color: Colors.black26,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 3.0)),
                                    Text(location, style: _txtStyleSub)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "\$" + price.toString(),
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Color(0xFF09314F),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Gotik"),
                              ),
                              Text(AppLocalizations.of(context).tr('perNight'),
                                  style: _txtStyleSub.copyWith(fontSize: 11.0))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}

class card extends StatelessWidget {
  final String dataUser;
  final List<DocumentSnapshot> list;
  card({this.dataUser, this.list});

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
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
                  child: Hero(
                    tag: 'hero-tag-${id}',
                    child: Material(
                      child: Container(
                        height: 220.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.cover),
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 2.0)
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 18.0,
                      color: Colors.black12,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.black26),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 18.0,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sofia",
                            fontSize: 13.0),
                      ),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Container(
                      height: 27.0,
                      width: 82.0,
                      decoration: BoxDecoration(
                          color: Color(0xFF09314F),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Center(
                        child: Text("\$ " + price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class cardCountry extends StatelessWidget {
  final Color colorTop, colorBottom;
  final String image, title;
  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 105.0,
            width: 105.0,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                  colors: [colorTop, colorBottom],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image,
                    height: 60,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Sofia",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
