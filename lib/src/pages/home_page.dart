import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/entry.dart';
import 'package:crypto_meal/src/data/global_variables.dart';
import 'package:crypto_meal/src/data/offer.dart';
import 'package:crypto_meal/src/data/sale.dart';
import 'package:crypto_meal/src/model/data.dart';
import 'package:crypto_meal/src/pages/profile_page/profile_page.dart';
import 'package:crypto_meal/src/themes/theme.dart';
import 'package:crypto_meal/src/widgets/product_card.dart';
import 'package:crypto_meal/src/widgets/product_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int toggle = 0;

  Widget _categoryWidget() {
    return Container(
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  setState(() {
                    if (model.isSelected) {
                      AppData.selectedCategory.remove(model);
                      model.isSelected = false;
                    } else {
                      AppData.selectedCategory.add(model);
                      model.isSelected = true;
                    }
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _toggleBar() {
    return Container(
      //  margin: EdgeInsets.symmetric(vertical: 10),
      width: 183, //AppTheme.fullWidth(context),
      height: 30,
      child: ToggleSwitch(
        //height: 30,
        minWidth: 90.0,
        cornerRadius: 20.0,
        activeBgColors: [
          [Colors.green],
          [Colors.orange]
        ],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.white,
        initialLabelIndex: toggle,
        totalSwitches: 2,
        labels: ['Sell', 'Buy'],
        radiusStyle: true,
        onToggle: (index) {
          setState(() {
            toggle = index;
          });
        },
      ),
    );
  }

  Widget _postButton() {
    return Container(
      //  margin: EdgeInsets.symmetric(vertical: 10),
      width: 150, //AppTheme.fullWidth(context),
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.orange[900],
        ),
        onPressed: () {
          publishData();
        },
        child: Text('Post'),
      ),
    );
  }

  void publishData() {
    if (toggle == 0) {
      database.uploadEntry(Offer(
          8.0, "id", "another1", "now", "5 minutes", "Brittain", 1, false));
    } else if (toggle == 1) {
      database.uploadEntry(Sale(
          8.0, "id", "another1", "now", "5 minutes", "Brittain", 1, false));
    }
  }

  Widget _topBar() {
    return Container(
        // margin: EdgeInsets.symmetric(vertical: 10),
        width: AppTheme.fullWidth(context),
        height: AppTheme.fullWidth(context) * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                _toggleBar(),
                SizedBox(width: 10),
                _postButton(),
              ],
            )
          ],
        ));
  }

  String dropdownValue = "North Ave";

  Widget dropDown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 115, //AppTheme.fullWidth(context),
      height: 45,
      child: DropdownButton<String>(
        value: dropdownValue,
        focusColor: Colors.orangeAccent[700],
        //dropdownColor: Colors.orangeAccent[700] ,
        //icon: const Icon(Icons.arrow_downward),
        iconEnabledColor: Colors.black,

        iconSize: 24,
        elevation: 16,
        dropdownColor: Colors.orangeAccent[700],

        style: const TextStyle(color: Colors.black),

        underline: Container(
          height: 2,
          color: Colors.orangeAccent[700],
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue ?? "";
          });
        },
        items: <String>[
          'North Ave',
          'West Village',
          'Brittain',
          'Exhibition Hall'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _filters() {
    return Container(
        //    margin: EdgeInsets.symmetric(vertical: 10),
        width: AppTheme.fullWidth(context),
        height: AppTheme.fullWidth(context) * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                dropDown(),
                SizedBox(width: 10),
                //dropDown(),
              ],
            )
          ],
        ));
  }

/*
   Widget _topBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * 0.2,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: EdgeInsets.only(left: 20),
        //scrollDirection: Axis.vertical,
        children:  <Widget>[
           // _search(),
           _toggleBar(),
          ],
      ),
    );
  } */

  Database database = GlobalVariables().database;

  // late Stream<List<Entry>> entries = database.streamSales(null, null);

  Widget _productWidget() {
    Stream<List<Entry>> entries = toggle == 0
        ? database.streamSales(null, null)
        : database.streamOffers(null, null);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: AppTheme.fullWidth(context) - 15,
        height: AppTheme.fullWidth(context) * 1.2,
        child: StreamBuilder<List<Entry>>(
          stream: entries,
          builder: (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!
                  .map((entry) => ProductCard(entry: entry))
                  .toList(),
            );
          },
        ));

    /*
            .map(
              (product) => ProductCard(
                product: product,
                onSelected: (model) {
                  setState(() {
                    AppData.productList.forEach((item) {
                      item.isSelected = false;
                    });
                    model.isSelected = true;
                  });
                },
              ),
            ) */
    // .toList(),
  }

/*
  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height - 210,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // _search(),
            _topBar(),
            //_filters(),
            _categoryWidget(),
            _productWidget(),
          ],
        ),
      ),
    );
  }
}
