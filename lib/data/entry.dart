import 'package:flutter/material.dart';

import 'entry_type.dart';
import 'location.dart';

class Entry {
  double price;
  String id;
  TimeOfDay startTime;
  TimeOfDay endTime;
  Location location;
  EntryType entryType;
  int numberRequests;

  Entry(
    this.price,
    this.id,
    this.startTime,
    this.endTime,
    this.location,
    this.entryType,
    this.numberRequests,
  );
}
