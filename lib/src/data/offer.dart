import 'package:flutter/material.dart';

import 'location.dart';
import 'entry.dart';

class Offer extends Entry {
  Offer(
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
