import 'package:crypto_meal/src/data/card_filter.dart';
import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/entry.dart';
import 'package:crypto_meal/src/data/profile.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDatabase implements Database {
  @override
  void approveEntry(Entry entry) {
    // TODO: implement approveEntry
  }

  @override
  void deleteEntry(Entry entry) {
    // TODO: implement deleteEntry
  }

  @override
  Profile getProfile(String id) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Stream<Entry> streamOffers(int number, CardFilter filter) {
    // TODO: implement streamOffers
    throw UnimplementedError();
  }

  @override
  Stream<Entry> streamSales(int number, CardFilter filter) {
    // TODO: implement streamSales
    throw UnimplementedError();
  }

  @override
  void uploadEntry(Entry entry) {
    // TODO: implement uploadEntry
  }
}
