import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:booking_hotel_firebase/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookitnow extends StatefulWidget {
  final String imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD,
      informationR,
      roomR,
      idR;
  final DocumentSnapshot listItem;
  final List<String> photoD, serviceD, descriptionD, imageR;
  final num ratingD, priceD, latLang1D, latLang2D, priceR;
  Bookitnow(
      {this.imageD,
      this.titleD,
      this.priceD,
      this.locationD,
      this.idD,
      this.photoD,
      this.serviceD,
      this.descriptionD,
      this.listItem,
      this.userId,
      this.typeD,
      this.emailD,
      this.nameD,
      this.photoProfileD,
      this.latLang1D,
      this.latLang2D,
      this.ratingD,
      this.idR,
      this.imageR,
      this.informationR,
      this.priceR,
      this.roomR});

  @override
  _BookitnowState createState() => _BookitnowState();
}

class _BookitnowState extends State<Bookitnow> {
  String _book = "Book Now";
  _check() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.titleD, "1");
  }

  String _valOccassion;
  List _listOccassion = [
    "1 Adults",
    "2 Adults",
    "3 Adults",
    "4 Adults",
    "5 Adults",
    "6 Adults",
    "7 Adults"
  ];

  /// Check user
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

  String _nama, _photoProfile, _email, _rooms, _location;

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

  void initState() {
    _getData();
    _checkFirst();
    super.initState();
  }

  Future<Null> _selectDateCheckIn(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        checkInController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectDateCheckOut(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        checkOutController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  DateTime selectedDate = DateTime.now();

  String _setCheckIn, _setCheckOut;

  TextEditingController locationController = new TextEditingController();
  TextEditingController countController = new TextEditingController();
  TextEditingController roomsController = new TextEditingController();
  TextEditingController checkInController = new TextEditingController();
  TextEditingController checkOutController = new TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void addDataBooking() {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        FirebaseFirestore.instance
            .collection("Booking")
            .doc("user")
            .collection(widget.titleD)
            .doc(widget.userId)
            .set({
          "Name": _nama,
          "photoProfile": _photoProfile,
          "Email": _email,
          "user ID": widget.userId,
          "Location": widget.locationD,
          "Check In": _setCheckIn,
          "Check Out": _setCheckOut,
          "Count": _valOccassion,
          "Rooms": _rooms + " Rooms",
          "Title": widget.titleD,
          "Room Name": widget.roomR,
          "Information Room": widget.informationR,
          "Price Room": widget.priceR,
        });
      });
    }

    void userSaved() {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .collection('Booking')
            .add({
          "title": widget.titleD,
          "image": widget.imageD,
          "price": widget.priceD,
          "photo": widget.photoD,
          "service": widget.serviceD,
          "description": widget.descriptionD,
          "userID": widget.userId,
          "type": widget.typeD,
          "latLang1": widget.latLang1D,
          "latLang2": widget.latLang2D,
          "rating": widget.ratingD,
          "Name": _nama,
          "photoProfile": _photoProfile,
          "Email": _email,
          "user ID": widget.userId,
          "Location": widget.locationD,
          "Check In": _setCheckIn,
          "Check Out": _setCheckOut,
          "Count": _valOccassion,
          "Rooms": _rooms + " Rooms",
          "Room Name": widget.roomR,
          "Image Room": widget.imageR,
          "Information Room": widget.informationR,
          "Price Room": widget.priceR
        });
      });
    }

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            AppLocalizations.of(context).tr('bookNow'),
            style: TextStyle(fontFamily: "Sofia", color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Stack(
              children: [
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
                    return Stack(
                      children: [
                        Text(
                          userDocument["name"] != null ? _nama : "Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0),
                        ),
                        Text(
                          userDocument["email"] != null
                              ? userDocument["email"]
                              : "Email",
                          style: TextStyle(
                              color: Colors.black38,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0),
                        ),
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
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0)
                              ]),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 20.0,
                                    bottom: 2.0),
                                child: Text(
                                  AppLocalizations.of(context).tr('location'),
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Container(
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12
                                                .withOpacity(0.1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: Theme(
                                        data: ThemeData(
                                          highlightColor: Colors.white,
                                          hintColor: Colors.white,
                                        ),
                                        child: TextFormField(
                                            onSaved: (input) =>
                                                _location = input,
                                            controller: locationController,
                                            decoration: InputDecoration(
                                              hintText: widget.locationD,
                                              hintStyle: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 20.0,
                                    bottom: 2.0),
                                child: Text(
                                  AppLocalizations.of(context).tr('checkIn'),
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 0.0),
                                child: Container(
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12
                                                .withOpacity(0.1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Center(
                                    child: Theme(
                                      data: ThemeData(
                                          canvasColor: Colors.deepPurpleAccent),
                                      child: InkWell(
                                        onTap: () {
                                          _selectDateCheckIn(context);
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 55.0,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Sofia",
                                              ),
                                              textAlign: TextAlign.left,
                                              onSaved: (String val) {
                                                _setCheckIn = val;
                                              },
                                              enabled: false,
                                              keyboardType: TextInputType.text,
                                              controller: checkInController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(13.0),
                                                hintText: "Date",
                                                hintStyle: TextStyle(
                                                    fontFamily: "Sofia",
                                                    fontSize: 17.0,
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                // labelText: 'Time',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 20.0,
                                    bottom: 2.0),
                                child: Text(
                                  AppLocalizations.of(context).tr('checkOut'),
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 0.0),
                                child: Container(
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12
                                                .withOpacity(0.1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Center(
                                    child: Theme(
                                      data: ThemeData(
                                          canvasColor: Colors.deepPurpleAccent),
                                      child: InkWell(
                                        onTap: () {
                                          _selectDateCheckOut(context);
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 55.0,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Sofia",
                                              ),
                                              textAlign: TextAlign.left,
                                              onSaved: (String val) {
                                                _setCheckOut = val;
                                              },
                                              enabled: false,
                                              keyboardType: TextInputType.text,
                                              controller: checkOutController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(13.0),
                                                hintText:
                                                    AppLocalizations.of(context)
                                                        .tr('date'),
                                                hintStyle: TextStyle(
                                                    fontFamily: "Sofia",
                                                    fontSize: 17.0,
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                // labelText: 'Time',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 5.0,
                                    bottom: 2.0),
                                child: Text(
                                  AppLocalizations.of(context).tr('count'),
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Container(
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12
                                                .withOpacity(0.1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: DropdownButton(
                                      hint: Text(
                                        AppLocalizations.of(context)
                                            .tr('adult'),
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                      underline: Container(),
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black),
                                      value: _valOccassion,
                                      items: _listOccassion.map((value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _valOccassion = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 5.0,
                                    bottom: 2.0),
                                child: Text(
                                  AppLocalizations.of(context).tr('rooms'),
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Container(
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12
                                                .withOpacity(0.1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: Theme(
                                        data: ThemeData(
                                          highlightColor: Colors.white,
                                          hintColor: Colors.white,
                                        ),
                                        child: TextFormField(
                                            // ignore: missing_return
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .tr('inputRooms');
                                              }
                                            },
                                            onSaved: (input) => _rooms = input,
                                            keyboardType: TextInputType.number,
                                            controller: roomsController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .tr('inputYourRooms'),
                                              hintStyle: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 50.0,
                              ),

                              /// Button
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, bottom: 20.0),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs;
                                    prefs =
                                        await SharedPreferences.getInstance();

                                    final formState = form.currentState;
                                    if (formState.validate()) {
                                      formState.save();
                                      try {
                                        // user.sendEmailVerification();

                                      } catch (e) {
                                        print('Error: $e');
                                        CircularProgressIndicator();
                                        print(e.message);
                                        print(_email);
                                      } finally {
                                        _check();

                                        if (prefs.getString(widget.titleD) ==
                                            null) {
                                          setState(() {
                                            _book = AppLocalizations.of(context)
                                                .tr('bookNow');
                                          });
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          bottomNavBar(
                                                            userID:
                                                                widget.userId,
                                                          )),
                                                  (Route<dynamic> route) =>
                                                      false);
                                          FirebaseFirestore.instance
                                              .collection('room')
                                              .doc(widget.listItem.id)
                                              .update({
                                            "quantity": FieldValue.increment(-1)
                                          });

                                          addDataBooking();
                                          userSaved();
                                        } else {
                                          setState(() {
                                            _book = AppLocalizations.of(context)
                                                .tr('booked');
                                          });
                                        }
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  AppLocalizations.of(context)
                                                      .tr('error')),
                                              content: Text(
                                                  AppLocalizations.of(context)
                                                      .tr('inputInformation')),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .tr('close')),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: Container(
                                    height: 55.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFF09314F),
                                              Color(0xFF09314F),
                                            ],
                                            begin: const FractionalOffset(
                                                0.0, 0.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp)),
                                    child: Center(
                                      child: Text(
                                        _book,
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
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
