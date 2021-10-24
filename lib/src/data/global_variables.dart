import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';

class GlobalVariables {
  static final GlobalVariables _globalVariables = GlobalVariables._internal();
  static String user_id = "";

  final Database database = FirestoreDatabase();
  factory GlobalVariables() {
    return _globalVariables;
  }
  GlobalVariables._internal();
}
