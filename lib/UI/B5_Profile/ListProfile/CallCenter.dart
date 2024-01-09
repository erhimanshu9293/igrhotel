// ignore_for_file: deprecated_member_use

import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class callCenter extends StatefulWidget {
  @override
  _callCenterState createState() => _callCenterState();
}

class _callCenterState extends State<callCenter> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _name, _email, _problem;
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController problem = new TextEditingController();

  void addData() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      FirebaseFirestore.instance.collection("Report").add({
        "Name": _name,
        "Email": _email,
        "Detail Problem": _problem,
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: Text(AppLocalizations.of(context).tr('callCenter'),
              style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 15.0),
          child: ListView(
            children: <Widget>[
              Text(
                AppLocalizations.of(context).tr('callCenter'),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFFFF8E1),
                    border: Border.all(width: 1.2, color: Color(0xFFFFAB40))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    AppLocalizations.of(context).tr('callCenterDesc'),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                        fontFamily: "Sans"),
                  ),
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      AppLocalizations.of(context).tr('name1'),
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      // ignore: missing_return
                      validator: (input) {
                        if (input.isEmpty) {
                          return AppLocalizations.of(context).tr('pleaseName');
                        }
                      },
                      onSaved: (input) => _name = input,
                      controller: nama,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 16.0,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.black12.withOpacity(0.01))),
                        contentPadding: EdgeInsets.all(13.0),
                        hintText: AppLocalizations.of(context).tr('inputName'),
                        hintStyle:
                            TextStyle(fontFamily: "Sans", fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(AppLocalizations.of(context).tr('email'),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      // ignore: missing_return
                      validator: (input) {
                        if (input.isEmpty) {
                          return AppLocalizations.of(context).tr('pleaseEmail');
                        }
                      },
                      onSaved: (input) => _email = input,
                      controller: email,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 16.0,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.black12.withOpacity(0.01))),
                        contentPadding: EdgeInsets.all(13.0),
                        hintText: AppLocalizations.of(context).tr('inputEmail'),
                        hintStyle:
                            TextStyle(fontFamily: "Sans", fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(AppLocalizations.of(context).tr('detailProblem'),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: TextFormField(
                        // ignore: missing_return
                        validator: (input) {
                          if (input.isEmpty) {
                            return AppLocalizations.of(context)
                                .tr('pleaseProblem');
                          }
                        },
                        maxLines: 10,
                        onSaved: (input) => _problem = input,
                        controller: problem,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.black12.withOpacity(0.01))),
                          contentPadding: EdgeInsets.all(13.0),
                          hintText:
                              AppLocalizations.of(context).tr('inputProblem'),
                          hintStyle:
                              TextStyle(fontFamily: "Sans", fontSize: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        final formState = _form.currentState;

                        if (formState.validate()) {
                          formState.save();
                          setState(() {});

                          addData();
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context).tr('error')),
                                  content: Text(AppLocalizations.of(context)
                                      .tr('pleaseInformation')),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(AppLocalizations.of(context)
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
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFF09314F),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('inputData'),
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
