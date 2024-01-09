import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel_firebase/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:booking_hotel_firebase/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'onBoardingVideo.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Gotik",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 15.0,
    color: Colors.black38,
    fontWeight: FontWeight.w400);

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      new PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context).tr('easyFind'),
            style: _fontHeaderStyle,
          ),
          body: Text(AppLocalizations.of(context).tr('descBoarding1'),
              textAlign: TextAlign.center, style: _fontDescriptionStyle),
          mainImage: Image.asset(
            'assets/image/onBoardingImage/onBoarding1.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
      new PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context).tr('bookingHotel'),
            style: _fontHeaderStyle,
          ),
          body: Text(AppLocalizations.of(context).tr('descBoarding1'),
              textAlign: TextAlign.center, style: _fontDescriptionStyle),
          mainImage: Image.asset(
            'assets/image/onBoardingImage/onBoarding2.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
      new PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context).tr('discoverPlace'),
            style: _fontHeaderStyle,
          ),
          body: Text(AppLocalizations.of(context).tr('descBoarding1'),
              textAlign: TextAlign.center, style: _fontDescriptionStyle),
          mainImage: Image.asset(
            'assets/image/onBoardingImage/onBoarding3.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
    ];

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: IntroViewsFlutter(
        pages,
        pageButtonsColor: Colors.black45,
        skipText: Text(
          AppLocalizations.of(context).tr('skip'),
          style: _fontDescriptionStyle.copyWith(
              color: Colors.purple,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0),
        ),
        doneText: Text(
          AppLocalizations.of(context).tr('done'),
          style: _fontDescriptionStyle.copyWith(
              color: Colors.purple,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0),
        ),
        onTapDoneButton: () {
          Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => new introVideo()));
        },
      ),
    );
  }
}
