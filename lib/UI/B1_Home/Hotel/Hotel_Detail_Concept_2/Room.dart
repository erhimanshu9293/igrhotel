import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RoomDetail.dart';

class Room extends StatefulWidget {
  final String imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD;
  final List<String> photoD, serviceD, descriptionD;
  final num ratingD, priceD, latLang1D, latLang2D;
  Room({
    this.imageD,
    this.titleD,
    this.priceD,
    this.locationD,
    this.idD,
    this.photoD,
    this.serviceD,
    this.descriptionD,
    this.userId,
    this.typeD,
    this.emailD,
    this.nameD,
    this.photoProfileD,
    this.latLang1D,
    this.latLang2D,
    this.ratingD,
  });

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
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

    var _appBar = PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppLocalizations.of(context).tr('chooseRoom'),
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),
    );

    var _recommended = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("room")
                .where('title', isEqualTo: widget.titleD)
                .snapshots(),
            builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      descriptionD: widget.descriptionD,
                      userId: widget.userId,
                      titleD: widget.titleD,
                      idD: widget.idD,
                      imageD: widget.imageD,
                      latLang1D: widget.latLang1D,
                      latLang2D: widget.latLang2D,
                      locationD: widget.locationD,
                      priceD: widget.priceD,
                      photoD: widget.photoD,
                      ratingD: widget.ratingD,
                      serviceD: widget.serviceD,
                      typeD: widget.typeD,
                      emailD: _email,
                      nameD: _nama,
                      photoProfileD: _photoProfile,
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
        ),
      ],
    );

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: _appBar,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Recommended
              _recommended,
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class cardList extends StatelessWidget {
  final String dataUser;
  final List<DocumentSnapshot> list;
  String imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD,
      titleR,
      informationR,
      roomR,
      idR,
      _email,
      _photoProfile,
      _nama;
  List<String> photoD, serviceD, descriptionD, imageR;
  num ratingD, priceD, latLang1D, latLang2D, priceR;

  var _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 19.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  cardList({
    this.dataUser,
    this.list,
    this.imageD,
    this.titleD,
    this.priceD,
    this.locationD,
    this.idD,
    this.photoD,
    this.serviceD,
    this.descriptionD,
    this.userId,
    this.typeD,
    this.emailD,
    this.nameD,
    this.photoProfileD,
    this.latLang1D,
    this.latLang2D,
    this.ratingD,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          List<String> image = List.from(list[i].data()['image']);
          String title = list[i].data()['title'].toString();
          String information = list[i].data()['information'].toString();
          String room = list[i].data()['room'].toString();
          String id = list[i].data()['id'].toString();
          num price = list[i].data()['priceRoom'];
          DocumentSnapshot _list = list[i];
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new RoomDetail(
                          userId: userId,
                          titleD: title,
                          idD: id,
                          imageR: image,
                          priceD: priceD,
                          roomR: room,
                          priceR: price,
                          informationR: information,
                          imageD: imageD,
                          latLang1D: latLang1D,
                          listItem: _list,
                          latLang2D: latLang2D,
                          locationD: locationD,
                          descriptionD: descriptionD,
                          photoD: photoD,
                          ratingD: ratingD,
                          serviceD: serviceD,
                          typeD: typeD,
                          emailD: _email,
                          nameD: _nama,
                          titleR: title,
                          photoProfileD: _photoProfile,
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
                height: 190.0,
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
                        height: 125.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(image[0]), fit: BoxFit.cover),
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
                                    room,
                                    style: _txtStyleTitle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
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
                                    color: Colors.blueAccent,
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
