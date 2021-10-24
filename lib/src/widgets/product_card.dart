import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/model/product.dart';
import 'package:crypto_meal/src/themes/light_color.dart';
import 'package:crypto_meal/src/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';
import 'package:crypto_meal/src/data/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_meal/src/data/global_variables.dart';
import 'package:crypto_meal/src/data/profile.dart';

class ProductCard extends StatelessWidget {
  final Entry entry;

  final Database database = GlobalVariables().database;

  //final Entry entry;
  // final ValueChanged<Product> onSelected;

  ProductCard({Key? key, required this.entry}) : super(key: key) {
    //entries = database.streamOffers(null, null);
  }

  @override
  Widget build(BuildContext context) {
    String a = "I AM SELLER, I POSTED";
    return Container(
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TitleText(
                text: entry.location,
                fontSize: 18,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(alignment: WrapAlignment.spaceBetween, children: <Widget>[
                  TitleText(
                    text: "Price: ${entry.price}",
                    fontSize: 16,
                  ),
                  SizedBox(width: 100),
                  status("THIS CARD IS MINE and requests"),
                ]),
                TitleText(
                  text: "Offer Time: ${entry.startTime} - ${entry.endTime}",
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buildChild(a),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget entryButton(String text) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.all(12.0),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () => {},
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(text),
          ),
        ),
      ),
    );
  }

  Widget status(String a) {
    if (a == "THIS CARD IS MINE and no requests") {
      return TitleText(
        text: "0 Requests",
        color: Colors.red,
        fontSize: 16,
      );
    } else if (a == "THIS CARD IS MINE and requests") {
      return TitleText(
        text: "X Requests",
        color: Colors.green,
        fontSize: 16,
      );
    } else if (a == "NOT MINE and NEW") {
      return TitleText(
        text: "Available",
        color: Colors.yellow,
        fontSize: 16,
      );
    } else if (a == "NOT MINE and WAITING") {
      return TitleText(
        text: "Waiting",
        color: Colors.orange,
        fontSize: 16,
      );
    } else if (a == "NOT MINE and CONFIRMED") {
      return TitleText(
        text: "Confirmed",
        color: Colors.green,
        fontSize: 16,
      );
    } else if (a == "NOT MINE and DON'T GET") {
      return TitleText(
        text: "Unavailable",
        color: Colors.red,
        fontSize: 16,
      );
    }
    return TitleText(text: "");
  }

  List<Widget> buildChild(String a) {
    if (a == "I AM BUYER, I WANT TO BUY, SEE NEW") {
      return <Widget>[
        entryButton("Buy"),
      ];
    } else if (a == "I AM BUYER, I WANT TO BUY, WAITING") {
      return <Widget>[
        entryButton("Cancel"),
      ];
    } else if (a == "I AM BUYER, I WANT TO BUY, ACCEPTED") {
      return <Widget>[
        entryButton("Complete"),
        SizedBox(width: 10),
        entryButton("Contact Seller"),
      ];
    } else if (a == "I AM BUYER, I MADE OFFER") {
      return <Widget>[
        entryButton("View Requests"),
        SizedBox(width: 10),
        entryButton("Edit"),
        SizedBox(width: 10),
        entryButton("Delete"),
      ];
    } else if (a == "I AM SELLER, I WANT TO SELL, SEE NEW") {
      return <Widget>[entryButton("Sell")];
    } else if (a == "I AM SELLER, I WANT TO SELL, WAITING") {
      return <Widget>[
        entryButton("Cancel"),
      ];
    } else if (a == "I AM SELLER, I WANT TO SELL, ACCEPTED") {
      return <Widget>[
        entryButton("Contact Seller"),
      ];
    } else if (a == "I AM SELLER, I POSTED") {
      return <Widget>[
        entryButton("View Requests"),
        SizedBox(width: 10),
        entryButton("Edit"),
        SizedBox(width: 10),
        entryButton("Delete"),
      ];
    }
    return <Widget>[];
  }
}
