import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class QuestionDetail extends StatefulWidget {
  QuestionDetail({Key key, this.documentId, this.name, this.photoProfile})
      : super(key: key);

  final String documentId;
  String name, _question, photoProfile;
  final TextEditingController nama = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController question = new TextEditingController();
  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  @override
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  var uuid = Uuid();
  var imagePicUrl;

  String data;
  String filename;
  bool imageUpload = true;

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataIn = prefs.getString("clockin") ?? 'default';
    return dataIn;
  }

  callme() async {
    await Future.delayed(Duration(seconds: 20));
    getData().then((value) => {
          setState(() {
            data = value;
            data = "test";
          })
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  File _image;
  @override
  void initState() {
    callme();
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
    String fileName = basename(_image.path);
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL();

      // print('File Uploaded');
      imagePicUrl = res.toString();
      if (imagePicUrl == null) {
        imageUpload = false;
      }
      setState(() {
        imagePicUrl = res.toString();
      });
      print("download url = $imagePicUrl");

      return imagePicUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    var v4 = uuid.v4();
    void addData() {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        FirebaseFirestore.instance
            .collection("Q&A")
            .doc(widget.documentId)
            .collection("question")
            .add({
          "Name": widget.name,
          "Photo Profile": widget.photoProfile,
          "Detail question": widget._question,
          "Image": imagePicUrl.toString(),
          "Answer": " ",
        });
      });
      Navigator.pop(context);
    }

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('questionTitle'),
            style: TextStyle(fontFamily: "Sofia", color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 15.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(AppLocalizations.of(context).tr('image'),
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
              SizedBox(
                height: 10.0,
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
                          color: Colors.black,
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
                                      backgroundColor: Colors.black,
                                      radius: 170.0,
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6i29mlctWXgW7c6eZ0QAoBoPk6Z9OyrjW5WvVjU-TZTsF0FX9C3PhJdv_MH-zrN1so0k&usqp=CAU"),
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
                                            color: Colors.black,
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
              Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(AppLocalizations.of(context).tr('yourQuestion'),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.0)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: TextFormField(
                        // ignore: missing_return
                        validator: (input) {
                          if (input.isEmpty) {
                            return AppLocalizations.of(context)
                                .tr('pleaseInputYourQuestion');
                          }
                        },
                        maxLines: 6,
                        onSaved: (input) => widget._question = input,
                        controller: widget.question,
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
                          hintText: AppLocalizations.of(context)
                              .tr('inputYourQuestion'),
                          hintStyle:
                              TextStyle(fontFamily: "Sans", fontSize: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    InkWell(
                      onTap: () {
                        final formState = _form.currentState;

                        if (formState.validate()) {
                          formState.save();

                          addData();
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context).tr('error')),
                                  content: Text(AppLocalizations.of(context)
                                      .tr('pleaseInputYourQuestion')),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
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
                        height: 52.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('inputData'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
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
