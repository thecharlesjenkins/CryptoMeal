import 'package:flutter/material.dart';

import 'location.dart';
import 'entry.dart';

class Offer extends Entry{
  Offer(
    double price, 
    String id,
    TimeOfDay startTime,
    TimeOfDay endTime,
    Location location,
    int numberRequests,
  ): super(price,id,startTime, endTime,location, numberRequests); 
    
}
