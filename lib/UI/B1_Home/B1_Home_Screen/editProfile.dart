import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class updateProfile extends StatefulWidget {
  final String name, photoProfile, uid;
  updateProfile({
    this.name,
    this.photoProfile,
    this.uid,
  });

  _updateProfileState createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {
  TextEditingController nameController, countryController, cityController;
  String name = "";
  var profilePicUrl;
  File _image;
  String filename;
  String data;
  bool imageUpload = true;
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataIn = prefs.getString("clockin") ?? 'default';
    return dataIn;
  }

  callme() async {
    await Future.delayed(Duration(seconds: 15));
    getData().then((value) => {
          setState(() {
            data = value;
            data = "test";
          })
        });
  }

  @override
  void initState() {
    if (profilePicUrl == null) {
      setState(() {
        profilePicUrl = widget.photoProfile;
      });
    }

    callme();
    nameController = TextEditingController(text: widget.name);
    // TODO: implement initState
    super.initState();
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
    setState(() {
      print("Profile Picture uploaded");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });

    setState(() {
      print("Profile Picture uploaded");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }

  Future selectPhoto() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        filename = basename(_image.path);
        uploadImage();
      });
    });
  }

  Future uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);

    // Waits till the file is uploaded then stores the download url
    // Uri location = (await uploadTask.).downloadUrl;
    // TaskSnapshot taskSnapshot =
    //     await ref.putFile(_image).whenComplete(() => ref.getDownloadURL());
    // print("dsad" + taskSnapshot.ref.getDownloadURL().toString());

    String image = "dsadas";
    FirebaseStorage.instance
        .refFromURL(image)
        .getDownloadURL()
        .then((url) async {
      print("irl " + url);
    });

    uploadTask.then((res) {
      String linkPP = res.ref.getDownloadURL().toString();
      print(linkPP);
      // print('File Uploaded');
      profilePicUrl = res.toString();
      if (profilePicUrl == null) {
        imageUpload = false;
      }
      setState(() {
        profilePicUrl = res.toString();
      });

      print("download urls = $linkPP");
      return linkPP;
    });
  }

  updateData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .update({
      "name": nameController.text,
      'photoProfile': profilePicUrl.toString(),
    });
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
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          elevation: 0.0,
          title: Text(AppLocalizations.of(context).tr('editProfile'),
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 17.0, color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 140.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          color: Colors.blueAccent,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 10.0,
                                spreadRadius: 4.0)
                          ]),
                      child: imageUpload
                          ? _image == null
                              ? new Stack(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
                                      radius: 170.0,
                                      backgroundImage:
                                          NetworkImage(widget.photoProfile),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          selectPhoto();
                                        },
                                        child: Container(
                                          height: 45.0,
                                          width: 45.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0)),
                                            color: Colors.blueAccent,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : data == null
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                    )
                                  : new CircleAvatar(
                                      backgroundImage: new FileImage(_image),
                                      radius: 220.0,
                                    )
                          : CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12.withOpacity(0.1)),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Theme(
                        data: ThemeData(
                          highlightColor: Colors.white,
                          hintColor: Colors.white,
                        ),
                        child: TextFormField(
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Sofia"),
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).tr('name'),
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontFamily: "Sofia"),
                              enabledBorder: new UnderlineInputBorder(
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
                height: 80.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 150.0),
                  child: InkWell(
                    onTap: () {
                      updateData();
                      _showDialog(context);
                    },
                    child: Container(
                      height: 55.0,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                            AppLocalizations.of(context).tr('updateProfile'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                                fontFamily: "Sofia")),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF09314F),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card Popup if success payment
_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    builder: (BuildContext context) => SimpleDialog(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: InkWell(
                    onTap: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Icon(
                      Icons.close,
                      size: 30.0,
                    ))),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
        Container(
            padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
            color: Colors.white,
            child: Icon(
              Icons.check_circle,
              size: 150.0,
              color: Colors.green,
            )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            AppLocalizations.of(context).tr('success'),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            AppLocalizations.of(context).tr('updateProfileSuccess'),
            style: TextStyle(fontSize: 17.0),
          ),
        )),
      ],
    ),
  );
}
