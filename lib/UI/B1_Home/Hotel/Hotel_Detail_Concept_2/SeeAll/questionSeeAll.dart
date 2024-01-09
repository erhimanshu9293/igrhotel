import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../question.dart';

class questionSeeAll extends StatelessWidget {
  questionSeeAll({Key key, this.title, this.name, this.photoProfile})
      : super(key: key);
  final String title, name, photoProfile;
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).tr('question'),
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 19.0,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Q&A")
                      .doc(title)
                      .collection('question')
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
                          "assets/image/illustration/noQuestion.jpeg",
                          fit: BoxFit.cover,
                          height: 170,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          AppLocalizations.of(context).tr('notHaveQuestion'),
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
                            "assets/image/illustration/noQuestion.jpeg",
                            fit: BoxFit.cover,
                            height: 170,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            AppLocalizations.of(context).tr('notHaveQuestion'),
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                color: Colors.black45,
                                fontSize: 15.0),
                          )
                        ]));
                      } else {
                        return questionCard(
                            userId: "", list: snapshot.data.docs);
                      }
                    }
                  }),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFF09314F),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new QuestionDetail(
                        documentId: title,
                        name: name,
                        photoProfile: photoProfile,
                      )));
            }),
      ),
    );
  }
}

class questionCard extends StatelessWidget {
  final String userId;
  questionCard({this.list, this.userId});
  final List<DocumentSnapshot> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: list.length,
          itemBuilder: (context, i) {
            String pp = list[i].data()['Photo Profile'].toString();
            String question = list[i].data()['Detail question'].toString();
            String name = list[i].data()['Name'].toString();
            String answer = list[i].data()['Answer'].toString();
            String image = list[i].data()['Image'].toString();
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
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
                                AppLocalizations.of(context).tr('ask'),
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
                                AppLocalizations.of(context).tr('answer'),
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
              ),
            );
          }),
    );
  }
}
