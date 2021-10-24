import 'package:crypto_meal/src/data/entry.dart';
import 'package:crypto_meal/src/data/profile.dart';

import 'card_filter.dart';

abstract class Database {
  Database();
  Stream<List<Entry>> streamSales(int? number, CardFilter? filter);
  Stream<List<Entry>> streamOffers(int? number, CardFilter? filter);
  Future<Profile> getProfile(String id);

  void uploadEntry(Entry entry);
  void deleteEntry(Entry entry);
  void approveEntry(Entry entry);
  void uploadProfile(Profile profile);
}
