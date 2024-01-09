// ignore_for_file: must_be_immutable

import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maps.dart';
import 'package:booking_hotel_firebase/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:booking_hotel_firebase/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BookingDetail extends StatefulWidget {
  String imageD,
      titleD,
      idD,
      typeD,
      userId,
      checkIn,
      checkOut,
      count,
      locationReservision,
      rooms,
      roomName,
      information;
  DocumentSnapshot listItem;
  List<String> photoD, serviceD, descriptionD;
  num ratingD, priceD, latLang1D, latLang2D, priceRoom;

  BookingDetail(
      {this.imageD,
      this.titleD,
      this.priceD,
      this.idD,
      this.photoD,
      this.serviceD,
      this.descriptionD,
      this.userId,
      this.listItem,
      this.typeD,
      this.latLang1D,
      this.latLang2D,
      this.checkIn,
      this.checkOut,
      this.count,
      this.locationReservision,
      this.rooms,
      this.ratingD,
      this.information,
      this.priceRoom,
      this.roomName});

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
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
          _photoProfile = userDocument["photoProfile"];

          setState(() {
            var userDocument = snapshot.data;
            _nama = userDocument["name"];
            _email = userDocument["email"];
            _photoProfile = userDocument["photoProfile"];
          });
        }

        var userDocument = snapshot.data;
        return Stack(
          children: <Widget>[Text(userDocument["name"])],
        );
      },
    );
  }

  String _book = "Book Now";

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

    var data = EasyLocalizationProvider.of(context).data;
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
                    location: widget.locationReservision,
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .tr('reservationInformation'),
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('roomName'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            widget.roomName,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('checkIn2'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            widget.checkIn,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('checkOut2'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            widget.checkOut,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('location2') + "\t",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            widget.locationReservision,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('room2'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            widget.rooms,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('information2'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            widget.information,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).tr('priceRoom2'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "\$ " + widget.priceRoom.toString(),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 18.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),

                    /// Description
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        AppLocalizations.of(context).tr('description'),
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
                        AppLocalizations.of(context).tr('service'),
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

                    /// Description
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        AppLocalizations.of(context).tr('photo'),
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
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
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => NetworkGiffyDialog(
                                    image: Image.network(
                                      widget.imageD,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                        AppLocalizations.of(context)
                                            .tr('cancelBooking'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600)),
                                    description: Text(
                                      AppLocalizations.of(context)
                                              .tr('areYouWant') +
                                          widget.titleD,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Popins",
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black26),
                                    ),
                                    onOkButtonPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  bottomNavBar(
                                                    userID: widget.userId,
                                                  )),
                                          (Route<dynamic> route) => false);

                                      FirebaseFirestore.instance
                                          .runTransaction((transaction) async {
                                        DocumentSnapshot snapshot =
                                            await transaction
                                                .get(widget.listItem.reference);
                                        await transaction
                                            .delete(snapshot.reference);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.remove(widget.titleD);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)
                                                    .tr('cancelBooking') +
                                                widget.titleD),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 3),
                                      ));
                                    },
                                  ));
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF09314F),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).tr('cancelBooking2'),
                              style: TextStyle(
                                  fontFamily: "Sofia", color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
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
      clipBehavior: Clip.hardEdge,
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
            height: (expandedHeight / 40) - (shrinkOffset / 40) + 24,
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

class reviewList extends StatelessWidget {
  String image, name, time;
  reviewList({this.image, this.name, this.time});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover),
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                              color: Colors.black12.withOpacity(0.05))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name,
                              style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w700,
                                fontSize: 17.0,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                              width: _width - 140.0,
                              child: Text(
                                AppLocalizations.of(context).tr('lorem'),
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.5,
                                    color: Colors.black45),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.justify,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
