import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  //final Entry entry;
  final ValueChanged<Product> onSelected;

  ProductCard({Key key, this.product, this.onSelected}) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   Product product;
//   @override
//   void initState() {
//     product = widget.product;
//     super.initState();
//   }

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
                text: "North Ave",
                fontSize: 18,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: "Price: \$X",
                  fontSize: 16,
                ),
                TitleText(
                  text: "Offer Time: XX:XX XM - XX:XX XM",
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
