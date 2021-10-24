import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/model/product.dart';
import 'package:crypto_meal/src/themes/light_color.dart';
import 'package:crypto_meal/src/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';
import 'package:crypto_meal/src/data/entry.dart';
import 'package:crypto_meal/src/data/sale.dart';
import 'package:crypto_meal/src/data/offer.dart';
import 'package:crypto_meal/src/data/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_meal/src/data/global_variables.dart';
import 'package:crypto_meal/src/data/profile.dart';

class ProductCard extends StatelessWidget {
  final Entry entry;
  final String profile_id = GlobalVariables.user_id;

  final Database database = GlobalVariables().database;

  //final Entry entry;
  // final ValueChanged<Product> onSelected;

  ProductCard({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  status(),
                ]),
                TitleText(
                  text: "Offer Time: ${entry.startTime} - ${entry.endTime}",
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buildChild()),
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
          onPressed: () {
            print("HEY");
            print(entry);
            print(entry.complete);
            if (text == "Edit") {
              //Edit Entry --> Pop-up (?)
            } else if (text == "Delete") {
              database.deleteEntry(entry);
            } else if (text == "View Requests") {
              //Do Nothing
            } else if (text == "Contact Seller") {
              //SMS API (?)
            } else if (text == "Buy") {
              database.approveEntry(entry);
            } else if (text == "Sell") {
              database.approveEntry(entry);
            } else if (text == "Complete") {
              database.deleteEntry(entry);
            }
          },
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(text),
          ),
        ),
      ),
    );
  }

  Widget status() {
    if (entry.profileId == profile_id && entry.numberRequests == 0) {
      return TitleText(
        text: "No Requests",
        color: Colors.red,
        fontSize: 16,
      );
    } else if (entry.profileId == profile_id) {
      return TitleText(
        text: "${entry.numberRequests} Requests",
        color: Colors.green,
        fontSize: 16,
      );
    } else if (!entry.complete) {
      return TitleText(
        text: "Available",
        color: Colors.yellow,
        fontSize: 16,
      );
    } else {
      return TitleText(
        text: "Confirmed",
        color: Colors.green,
        fontSize: 16,
      );
    }
    return TitleText(text: "");
  }

  List<Widget> buildChild() {
    if (entry.profileId != profile_id && entry is Sale && !entry.complete) {
      return <Widget>[
        entryButton("Buy"),
      ];
    } else if (entry.profileId != profile_id && entry is Sale) {
      return <Widget>[
        entryButton("Complete"),
        SizedBox(width: 10),
        entryButton("Contact Seller"),
      ];
    } else if (entry.profileId == profile_id &&
        entry is Offer &&
        !entry.complete) {
      return <Widget>[
        entryButton("View Requests"),
        SizedBox(width: 10),
        entryButton("Edit"),
        SizedBox(width: 10),
        entryButton("Delete"),
      ];
    } else if (entry.profileId != profile_id &&
        entry is Offer &&
        !entry.complete) {
      return <Widget>[entryButton("Sell")];
    } else if (entry.profileId != profile_id && entry is Offer) {
      return <Widget>[
        entryButton("Contact Seller"),
      ];
    } else if (entry.profileId == profile_id &&
        entry is Sale &&
        !entry.complete) {
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
