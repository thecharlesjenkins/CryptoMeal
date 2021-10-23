import 'package:crypto_meal/src/pages/mainPage.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(
            title: 'CryptoMeal',
          ),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
