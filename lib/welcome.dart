import 'package:crypto_meal/provider/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:crypto_meal/src/pages/mainPage.dart';

import 'src/data/profile.dart';

List items = [
  {
    "header": "Welcome",
    "description": "Get on-campus meals while connecting with your peers",
    "image": "assets/images/undraw_Joyride_re_968t.png",
  },
  {
    "header": "Build",
    "description": "Set up an in-app wallet to aid you in your transfers",
    "image": "assets/images/undraw_Setup_re_y9w8.png",
    "buttonText": "Build Wallet"
  },
  {
    "header": "Create",
    "description": "Please fill out your profile details:",
    "image": "assets/images/undraw_data_input_fxv2.png",
    "inputFlag": true
  }
];

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String name = "";
  String phnumber = "";
  String username = "";

  List<Widget> sliders = [];

  List<Widget> indicator() => List<Widget>.generate(
      sliders.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color(0XFF256075)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;

  final _pageViewController = new PageController();

  @override
  Widget build(BuildContext context) {
    sliders = items
        .map((item) => Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.fitWidth,
                    width: 220.0,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Text(item['header'],
                            style: const TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.w300,
                                color: Color(0XFF3F3D56),
                                height: 2.0)),
                        Text(
                          item['description'],
                          style: const TextStyle(
                              color: Colors.grey,
                              letterSpacing: 1.2,
                              fontSize: 16.0,
                              height: 1.3),
                          textAlign: TextAlign.center,
                        ),
                        if (item.containsKey('buttonText'))
                          MaterialButton(
                            onPressed: () {},
                            color: Colors.grey,
                            child: Text(item['buttonText']),
                          )
                      ],
                    ),
                  ),
                ),
                if (item.containsKey('inputFlag'))
                  Flexible(
                      child: Container(
                          child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            onSaved: (String? value) {
                              name = value ?? "";
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter your name'),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            onSaved: (String? value) {
                              username = value ?? "";
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter your username'),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            onSaved: (String? value) {
                              phnumber = value ?? "";
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your phone number',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),

                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                minimumSize: Size(double.infinity, 50),
                              ),
                              icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                              label: Text('Sign Up with Google'),
                              onPressed: () {
                                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                provider.googleLogin();
                              }
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 1.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();
                                    Profile(0, name, username, phnumber);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MainPage(
                                        title: 'CryptoMeal',
                                      )),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ))
                        ]),
                  )))
              ],
            )))
        .toList();

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: sliders.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  setState(() {
                    currentPage = _pageViewController.page ?? 0.0;
                  });
                });

                return sliders[index];
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
