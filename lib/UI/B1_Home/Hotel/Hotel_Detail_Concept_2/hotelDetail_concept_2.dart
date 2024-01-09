import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Gallery.dart';
import 'Room.dart';
import 'SeeAll/questionSeeAll.dart';
import 'SeeAll/reviewSeeAll.dart';
import 'maps.dart';

class hotelDetail2 extends StatefulWidget {
  final String imageD, titleD, locationD, idD, typeD, userId;
  final List<String> photoD, serviceD, descriptionD;
  final num ratingD, priceD, latLang1D, latLang2D;

  hotelDetail2(
      {this.imageD,
      this.titleD,
      this.priceD,
      this.locationD,
      this.idD,
      this.photoD,
      this.serviceD,
      this.descriptionD,
      this.userId,
      this.typeD,
      this.latLang1D,
      this.latLang2D,
      this.ratingD});

  @override
  _hotelDetail2State createState() => _hotelDetail2State();
}

class _hotelDetail2State extends State<hotelDetail2> {
  /// Check user

  // ignore: unused_field
  String _book = "Book Now";
  _checkFirst() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString(widget.titleD) == null) {
      setState(() {
        _book = "Book Now";
      });
    } else {
      setState(() {
        _book = "Booked";
      });
    }
  }

  String _nama, _photoProfile, _email;

  void _getData() {
    StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        } else {
          var userDocument = snapshot.data;
          _nama = userDocument["name"];
          _email = userDocument["email"];
          _photoProfile = userDocument["photoProfile"] != null
              ? userDocument["photoProfile"]
              : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";

          setState(() {
            var userDocument = snapshot.data;
            _nama = userDocument["name"];
            _email = userDocument["email"];
            _photoProfile = userDocument["photoProfile"] != null
                ? userDocument["photoProfile"]
                : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";
            ;
          });
        }

        var userDocument = snapshot.data;
        return Stack(
          children: <Widget>[Text(userDocument["name"])],
        );
      },
    );
  }

  final Set<Marker> _markers = {};

  void initState() {
    _getData();
    _checkFirst();
    _markers.add(
      Marker(
        markerId:
            MarkerId(widget.latLang1D.toString() + widget.latLang2D.toString()),
        position: LatLng(widget.latLang1D, widget.latLang2D),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    double _height = MediaQuery.of(context).size.height;

    var _location = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 50.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            AppLocalizations.of(context).tr('location'),
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Stack(
            children: <Widget>[
              Container(
                height: 190.0,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(40.7078523, -74.008981),
                    zoom: 13.0,
                  ),
                  markers: _markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 135.0, right: 60.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => maps()));
                    },
                    child: Container(
                      height: 35.0,
                      width: 95.0,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Center(
                        child: Text(AppLocalizations.of(context).tr('seeMap'),
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Sofia")),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              /// AppBar
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                    expandedHeight: _height - 30.0,
                    img: widget.imageD,
                    id: widget.idD,
                    title: widget.titleD,
                    price: widget.priceD,
                    location: widget.locationD,
                    ratting: widget.ratingD),
                pinned: true,
              ),

              SliverToBoxAdapter(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        } else {
                          var userDocument = snapshot.data;
                          _nama = userDocument["name"];
                          _email = userDocument["email"];
                          _photoProfile = userDocument["photoProfile"];
                        }

                        var userDocument = snapshot.data;
                        return Container();
                      },
                    ),

                    /// Description
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        AppLocalizations.of(context).tr('details'),
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.descriptionD
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: new Text(
                                            item,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black54,
                                                fontSize: 18.0),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList()),
                    ),

                    /// Location
                    _location,

                    /// service
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        AppLocalizations.of(context).tr('amneties'),
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    //Text(_nama),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.serviceD
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "-   ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24.0),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: new Text(
                                            item,
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black54,
                                                fontSize: 18.0),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList()),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('photos'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.justify,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      gallery(image: widget.photoD)));
                            },
                            child: Text(
                              AppLocalizations.of(context).tr('seeAll'),
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black38,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 0.0, right: 0.0, bottom: 40.0),
                      child: Container(
                        height: 150.0,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: widget.photoD
                                .map((item) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, bottom: 10.0),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    opaque: false,
                                                    pageBuilder:
                                                        (BuildContext context,
                                                            _, __) {
                                                      return new Material(
                                                        color: Colors.black54,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  30.0),
                                                          child: InkWell(
                                                            child: Hero(
                                                                tag:
                                                                    "hero-grid-${widget.idD}",
                                                                child: Image
                                                                    .network(
                                                                  item,
                                                                  width: 300.0,
                                                                  height: 300.0,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds:
                                                                500)));
                                          },
                                          child: Container(
                                            height: 130.0,
                                            width: 130.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(item),
                                                    fit: BoxFit.cover),
                                                color: Colors.black12,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5.0,
                                                      color: Colors.black12
                                                          .withOpacity(0.1),
                                                      spreadRadius: 2.0)
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 0.0,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).tr('question'),
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => questionSeeAll(
                                          title: widget.titleD,
                                          name: _nama,
                                          photoProfile: _photoProfile,
                                        )));
                              },
                              child: Text(
                                AppLocalizations.of(context).tr('seeAll'),
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 0.0,
                    ),
                    // Question
                    Column(
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Q&A")
                                .doc(widget.titleD)
                                .collection('question')
                                .snapshots(),
                            builder: (
                              context,
                              snapshot,
                            ) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Column(children: [
                                    Image.asset(
                                        "assets/image/illustration/noQuestion.jpeg"),
                                    Text(AppLocalizations.of(context)
                                        .tr('notHaveQuestion'))
                                  ]),
                                ));
                              } else {
                                if (snapshot.data.docs.isEmpty) {
                                  return Center(
                                      child: Column(children: [
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Image.asset(
                                      "assets/image/illustration/noQuestion.jpeg",
                                      fit: BoxFit.cover,
                                      height: 170,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .tr('notHaveQuestion'),
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black45,
                                          fontSize: 15.0),
                                    )
                                  ]));
                                } else {
                                  return questionCard(
                                      userId: widget.userId,
                                      list: snapshot.data.docs);
                                }
                              }
                            })
                      ],
                    ),

                    // Review
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 0.0,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).tr('reviews'),
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            new reviewSeeAll(
                                              name: _nama,
                                              photoProfile: _photoProfile,
                                              title: widget.titleD,
                                            )));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).tr('seeAll'),
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black54,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Reviews")
                                    .doc(widget.titleD)
                                    .collection('rating')
                                    .snapshots(),
                                builder: (
                                  context,
                                  snapshot,
                                ) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: Column(children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Image.asset(
                                        "assets/image/illustration/noReview.jpeg",
                                        fit: BoxFit.cover,
                                        height: 170,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .tr('notHaveReview'),
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black45,
                                            fontSize: 15.0),
                                      )
                                    ]));
                                  } else {
                                    if (snapshot.data.docs.isEmpty) {
                                      return Center(
                                          child: Column(children: [
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Image.asset(
                                          "assets/image/illustration/noReview.jpeg",
                                          fit: BoxFit.cover,
                                          height: 170,
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .tr('notHaveReview'),
                                          style: TextStyle(
                                              fontFamily: "Sofia",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black45,
                                              fontSize: 15.0),
                                        )
                                      ]));
                                    } else {
                                      return ratingCard(
                                          userId: widget.userId,
                                          list: snapshot.data.docs);
                                    }
                                  }
                                })
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        )
                      ],
                    ),

                    /// Button
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 10.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new Room(
                                    userId: widget.userId,
                                    titleD: widget.titleD,
                                    idD: widget.idD,
                                    imageD: widget.imageD,
                                    latLang1D: widget.latLang1D,
                                    latLang2D: widget.latLang2D,
                                    locationD: widget.locationD,
                                    priceD: widget.priceD,
                                    descriptionD: widget.descriptionD,
                                    photoD: widget.photoD,
                                    ratingD: widget.ratingD,
                                    serviceD: widget.serviceD,
                                    typeD: widget.typeD,
                                    emailD: _email,
                                    nameD: _nama,
                                    photoProfileD: _photoProfile,
                                  )));
                        },
                        child: Container(
                          height: 55.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF09314F),
                                    Color(0xFF09314F),
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('bookNow'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, id, title, location;
  num price;
  double ratting;

  MySliverAppBar(
      {@required this.expandedHeight,
      this.img,
      this.id,
      this.title,
      this.price,
      this.location,
      this.ratting});

  var _txtStyleTitle = TextStyle(
    color: Colors.black54,
    fontFamily: "Sofia",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Sofia",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/image/logo/logo.png",
            height: (expandedHeight / 30) - (shrinkOffset / 40) + 24,
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-${id}',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(img),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 620.0),
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
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 40.0),
              child: Container(
                height: 170.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.85)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    width: 210.0,
                                    child: Text(
                                      title,
                                      style: _txtStyleTitle.copyWith(
                                          fontSize: 27.0),
                                      overflow: TextOverflow.clip,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "\$ " + price.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Color(0xFF09314F),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Gotik"),
                                      ),
                                      Text(
                                          AppLocalizations.of(context)
                                              .tr('perNight'),
                                          style: _txtStyleSub.copyWith(
                                              fontSize: 11.0))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star_half,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 14.0,
                                            color: Colors.black26,
                                          ),
                                          Text(
                                            location,
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 14.5,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w400),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.white70,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class questionCard extends StatelessWidget {
  final String userId;
  questionCard({this.list, this.userId});
  final List<DocumentSnapshot> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: 1,
          itemBuilder: (context, i) {
            String pp = list[i].data()['Photo Profile'].toString();
            String question = list[i].data()['Detail question'].toString();
            String name = list[i].data()['Name'].toString();
            String answer = list[i].data()['Answer'].toString();
            String image = list[i].data()['Image'].toString();
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(pp), fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: EdgeInsets.only(
                        left: 15.0, top: 0.0, bottom: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Color(0xFF09314F).withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        image == "null"
                            ? Container(height: 1, width: 1)
                            : Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Wrap(
                          children: [
                            Text(
                              AppLocalizations.of(context).tr('ask') + ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                            ),
                            Text(
                              question,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Wrap(
                          children: [
                            Text(
                              AppLocalizations.of(context).tr('answer') + ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                            ),
                            Text(
                              answer,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}

class ratingCard extends StatelessWidget {
  final String userId;
  ratingCard({this.list, this.userId});
  final List<DocumentSnapshot> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: 1,
          itemBuilder: (context, i) {
            String pp = list[i].data()['Photo Profile'].toString();
            String review = list[i].data()['Detail rating'].toString();
            String name = list[i].data()['Name'].toString();
            String rating = list[i].data()['rating'].toString();
            return Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(
                                pp,
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 22.0,
                              color: Colors.yellow,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                rating,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Sofia",
                                    fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              width: 35.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.only(
                          left: 15.0, top: 15.0, bottom: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        color: Color(0xFF09314F).withOpacity(0.1),
                      ),
                      child: Text(
                        review,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 17.5),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
