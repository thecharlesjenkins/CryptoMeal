import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/global_variables.dart';
import 'package:crypto_meal/src/data/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'user_preferences.dart';
import 'appbar.dart';
import 'button.dart';
import 'numbers.dart';
import 'profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Database database = GlobalVariables().database;
  String user_id = GlobalVariables.user_id;

  @override
  Widget build(BuildContext context) {
    final user2 = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user2.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          FutureBuilder<Profile>(
            future: database.getProfile(user_id),
            builder: (futureContext, AsyncSnapshot<Profile> snapshot) {
              return buildName(snapshot.data ?? Profile("", "", "", ""));
            },
          ),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          //buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(Profile user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.phnumber,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Update',
        onClicked: () {},
      );

//  Widget buildAbout(User user) => Container(
//    padding: EdgeInsets.symmetric(horizontal: 48),
//    child: Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//        Text(
//          'About',
//          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//        ),
//        const SizedBox(height: 16),
//        Text(
//          user.about,
//          style: TextStyle(fontSize: 16, height: 1.4),
//        ),
//      ],
//    ),
//  );
}
