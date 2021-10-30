import 'package:crypto_meal/provider/google_sign_in.dart';
import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/global_variables.dart';
import 'package:crypto_meal/src/pages/setup/setup_screen_form.dart';
import 'package:crypto_meal/src/pages/setup/setup_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../data/profile.dart';
import 'main_page.dart';
import 'setup/setup_screen_basics.dart';

enum Screens { welcome, wallet, profile }

final StatedSetupScreenComponent welcomeScreen = (state) {
  return CompositeSetupScreenComponent(
    child: HeaderSetupScreenComponent(
        image: 'assets/images/undraw_Joyride_re_968t.png',
        title: 'Welcome',
        description: 'Get on-campus meals while connecting with your peers'),
  );
};

typedef StatedSetupScreenComponent = SetupScreenComponent Function(
    _WelcomeScreenState state);

final StatedSetupScreenComponent walletScreen =
    (state) => CompositeSetupScreenComponent(
          child: HeaderSetupScreenComponent(
            image: 'assets/images/undraw_Setup_re_y9w8.png',
            title: 'Build',
            description: 'Set up an in-app wallet to aid you in your transfers',
            child: FormSetupScreenComponent(
              formSetupScreenComponentCompletion: (context) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                state.updateCompletedScreens(Screens.wallet);
              },
              children: (context) => [
                TextFormFieldSetupScreenComponent(
                  decoration: const InputDecoration(
                      hintText: 'Enter your Ethereum wallet private key'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        );

final StatedSetupScreenComponent profileScreen = (state) =>
    CompositeSetupScreenComponent(
      child: HeaderSetupScreenComponent(
        image: 'assets/images/undraw_data_input_fxv2.png',
        title: 'Create',
        description: 'Please fill out your profile details:',
        child: FormSetupScreenComponent(
          formSetupScreenComponentCompletion: (context) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            database.uploadProfile(new_user);
            /*database.Profile(
                                        "0", name, username, phnumber); */
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(
                        title: 'CryptoMeal',
                      )),
            );
          },
          children: (context) => [
            TextFormField(
              onSaved: (String? value) {
                new_user.name = value ?? "";
              },
              decoration: const InputDecoration(hintText: 'Enter your name'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (String? value) {
                new_user.username = value ?? "";
                new_user.id = value ?? "";
                GlobalVariables.user_id = value ?? "";
              },
              decoration:
                  const InputDecoration(hintText: 'Enter your username'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (String? value) {
                new_user.phnumber = value ?? "";
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
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
            ),
          ],
        ),
      ),
    );

typedef StateScreenComponentList = List<SetupScreenComponent> Function(
    _WelcomeScreenState state);

final StateScreenComponentList pages = (state) => [
      welcomeScreen(state),
      walletScreen(state),
      profileScreen(state),
    ];

Database database = GlobalVariables().database;
String user_id = GlobalVariables.user_id;

String name = "";
String phnumber = "";
String username = "";

Profile new_user = Profile(username, name, username, phnumber);

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> sliders = [];
  List<Screens> _completedScreens = [];
  double currentPage = 0.0;

  _WelcomeScreenState() {
    sliders = pages(this);
    _completedScreens.add(Screens.welcome);
  }

  void updateCompletedScreens(Screens screen) {
    if (!_completedScreens.contains(screen)) {
      setState(
        () {
          _completedScreens.add(screen);
          _pageViewController.animateToPage((currentPage + 1).round(),
              curve: Curves.easeIn, duration: Duration(seconds: 1));
        },
      );
    }
  }

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
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

  final _pageViewController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: _completedScreens.length + 1,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(
                  () {
                    setState(
                      () {
                        currentPage = _pageViewController.page ?? 0.0;
                      },
                    );
                  },
                );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
