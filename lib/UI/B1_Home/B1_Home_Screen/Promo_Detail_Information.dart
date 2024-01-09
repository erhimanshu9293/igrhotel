import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';

class PromoDetailInformation extends StatelessWidget {
  final String image;
  final List<String> description;
  PromoDetailInformation({Key key, this.image, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    final key = new GlobalKey<ScaffoldState>();

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
        title: Text(AppLocalizations.of(context).tr('promoDetail'),
            style: TextStyle(
                fontFamily: "Sofia", color: Colors.black, fontSize: 18.0)),
      ),
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: key,
        appBar: _appBar,
        body: EasyLocalizationProvider(
          data: data,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.network(image)),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 0.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: description
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10.0, bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: new Text(
                                        item,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black54,
                                            fontSize: 17.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: InkWell(
                    onTap: () {
                      // ignore: deprecated_member_use
                      key.currentState.showSnackBar(new SnackBar(
                        content: new Text(
                          AppLocalizations.of(context)
                              .tr('You get promo check your mail!'),
                        ),
                      ));
                    },
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: Color(0xFF09314F)),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).tr('getPromo'),
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
