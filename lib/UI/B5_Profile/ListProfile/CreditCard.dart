import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_delegate.dart';
import 'package:booking_hotel_firebase/Library/Multiple_Language/Language_Library/lib/easy_localization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class addCreditCard extends StatefulWidget {
  final String name, password, photoProfile, uid, email;

  addCreditCard(
      {this.name, this.photoProfile, this.uid, this.email, this.password});

  @override
  _addCreditCardState createState() => _addCreditCardState();
}

class _addCreditCardState extends State<addCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  addData() async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection("CreditCard")
          .add({
        "cardNumber": cardNumber,
        'expiryDate': expiryDate,
        "cardHolderName": cardHolderName,
        'cvvCode': cvvCode,
      });
    });
    Navigator.of(context).pop();
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
          title: Text(
            AppLocalizations.of(context).tr('creditCard'),
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w800,
                fontSize: 22.0,
                color: Colors.black),
          ),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 0.0, right: 0.0),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Text(
                      AppLocalizations.of(context).tr('enterCreditCard'),
                      style: TextStyle(
                          fontFamily: "Sofia",
                          color: Colors.black26,
                          fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    cardBgColor: Color(0xFF8DA2BF),
                  ),
                  SingleChildScrollView(
                    child: CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 20.0, top: 50.0),
                    child: InkWell(
                      onTap: () {
                        addData();
                      },
                      child: Container(
                        height: 53.0,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).tr('addCreditCard'),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Sofia",
                                fontSize: 19.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xFF8DA2BF)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
