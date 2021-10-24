import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_meal/src/data/firestore_database.dart';

class GlobalVariables {
  static final GlobalVariables _globalVariables = GlobalVariables._internal();
  String user_id = "";

  final Database database = FirestoreDatabase();
  factory GlobalVariables() {
    return _globalVariables;
  }

  user_id_upload(String user_id) {
    this.user_id = user_id;
  }

  GlobalVariables._internal();
}
