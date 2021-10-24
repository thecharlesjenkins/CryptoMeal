import 'package:flutter/material.dart';

import 'location.dart';
import 'entry.dart';

class Offer extends Entry{
  Offer(
    double price, 
    String id,
    TimeOfDay startTime,
    TimeOfDay endTime,
    String location,
    int numberRequests,
    bool complete,
  ): super(price,id,startTime, endTime, location, numberRequests, complete); 
    
}
