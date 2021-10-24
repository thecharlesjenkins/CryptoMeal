import 'package:flutter/material.dart';
import 'location.dart';

class Entry {
  double price;
  String profileId;
  String id;
  String startTime;
  String endTime;
  String location;
  int numberRequests;
  bool complete;

  Entry(
    this.price,
    this.profileId,
    this.id,
    this.startTime,
    this.endTime,
    this.location,
    this.numberRequests,
    this.complete,
  );

  Map<String, dynamic> tojson() => {
        'price': this.price,
        'profileId': this.profileId,
        'id': this.id,
        'startTime': this.startTime,
        'endTime': this.endTime,
        'location': this.location,
        'numberRequests': this.numberRequests,
        'complete': this.complete,
      };
}
