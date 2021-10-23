import 'package:crypto_meal/data/entry.dart';
import 'package:crypto_meal/data/profile.dart';

import 'card_filter.dart';

abstract class Database {
  Stream<Entry> streamSales(int number, CardFilter filter);
  Stream<Entry> streamOffers(int number, CardFilter filter);
  Profile getProfile(String id);

  void uploadEntry(Entry entry);
  void deleteEntry(Entry entry);
  void approveEntry(Entry entry);
}
