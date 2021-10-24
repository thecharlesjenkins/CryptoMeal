import 'package:flutter/material.dart';

import 'location.dart';
import 'entry.dart';

class Sale extends Entry {
  Sale(
    double price,
    String profileId,
    String id,
    String startTime,
    String endTime,
    String location,
    int numberRequests,
    bool complete,
  ) : super(price, profileId, id, startTime, endTime, location, numberRequests,
            complete);
}
