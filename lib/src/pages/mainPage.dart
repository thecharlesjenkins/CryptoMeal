import 'package:crypto_meal/src/pages/home_page.dart';
import 'package:crypto_meal/src/pages/profile_page/profile_page.dart';
import 'package:crypto_meal/src/themes/light_color.dart';
import 'package:crypto_meal/src/themes/theme.dart';
import 'package:crypto_meal/src/widgets/extentions.dart';
import 'package:crypto_meal/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

import '../../transaction.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  int balance = 0;

  Widget _profile(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: IconButton(
          icon: Icon(
            Icons.person,
          ),
          color: LightColor.orange,
          onPressed: () {
            //navigateToProfilePage(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage()));
          }),
    ); //.ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Future navigateToProfilePage(context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  //text: isHomePageSelected ? 'Our' : 'Shopping',
                  text: 'df',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Spacer(),
            !isHomePageSelected
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete_outline,
                      color: LightColor.orange,
                    ),
                  ).ripple(() {},
                    borderRadius: BorderRadius.all(Radius.circular(13)))
                : SizedBox()
          ],
        ));
  }

  Widget _refresh() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Transact.refresh();
            },
            icon: Icon(Icons.money)),
        Text(balance.toString())
      ],
    );
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
                TitleText(
                  //text: isHomePageSelected ? 'Our' : 'Shopping',
                  text: 'CryptoMeal',

                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(width: 50),
                _refresh(),
                SizedBox(width: 50),
                _profile(Icons.person),
              ],
            )
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _topBar(),
                    MyHomePage(
                      key: null,
                      title: 'dd',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
