import 'package:crypto_meal/data/card_filter.dart';
import 'package:crypto_meal/data/database.dart';
import 'package:crypto_meal/data/entry.dart';
import 'package:crypto_meal/data/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
