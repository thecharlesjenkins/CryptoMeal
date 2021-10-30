import 'package:crypto_meal/provider/google_sign_in.dart';
import 'package:crypto_meal/src/config/route.dart';
import 'package:crypto_meal/src/pages/main_page.dart';
import 'package:crypto_meal/src/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'src/pages/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'CryptoMeal ',
          theme: AppTheme.lightTheme,
          home: WelcomeScreen(),
        ));
  }
}
