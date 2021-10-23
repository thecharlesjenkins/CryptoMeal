import 'package:flutter/material.dart';
import 'location.dart';

class Entry {
  double price;
  String id;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String location;
  int numberRequests;

  Entry(
    this.price,
    this.id,
    this.startTime,
    this.endTime,
    this.location,
    this.numberRequests,
  );
}
