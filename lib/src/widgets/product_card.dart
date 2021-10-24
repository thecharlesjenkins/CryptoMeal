import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/model/product.dart';
import 'package:crypto_meal/src/themes/light_color.dart';
import 'package:crypto_meal/src/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';
import 'package:crypto_meal/src/data/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_meal/src/data/global_variables.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: "Price: ${entry.price}",
                  fontSize: 16,
                ),
                TitleText(
                  text: "Offer Time: ${entry.startTime} - ${entry.endTime}",
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    entryButton("buy"),
                    SizedBox(width: 10),
                    entryButton("sell"),
                  ],
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
            backgroundColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
            primary: Colors.blue,
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {},
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
