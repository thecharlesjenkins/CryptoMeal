import 'package:crypto_meal/src/data/card_filter.dart';
import 'package:crypto_meal/src/data/database.dart';
import 'package:crypto_meal/src/data/entry.dart';
import 'package:crypto_meal/src/data/offer.dart';
import 'package:crypto_meal/src/data/profile.dart';
import 'package:crypto_meal/src/data/sale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase implements Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  //FirestoreDatabase()

  @override
  void approveEntry(Entry entry) {
    // TODO: implement approveEntry
    
    CollectionReference entries;

    if (entry is Sale) {
      entries = FirebaseFirestore.instance.collection('sales');
    } else {
      entries = FirebaseFirestore.instance.collection('offers');
    }


    deleteEntry(entry);
    uploadEntry(Entry(entry.price, entry.id, entry.startTime, entry.endTime, entry.location, entry.numberRequests, true));


  }


  @override
  void deleteEntry(Entry entry) {
    // TODO: implement deleteEntry
    CollectionReference entries;

    if (entry is Sale) {
      entries = FirebaseFirestore.instance.collection('sales');
    } else {
      entries = FirebaseFirestore.instance.collection('offers');
    }

    entries.doc(entry.id).delete();



  }

  @override
  Future<Profile> getProfile(String id) async {
    // TODO: implement getProfile

      CollectionReference collection = FirebaseFirestore.instance.collection('profiles');

      DocumentSnapshot<Object?> document = await collection.doc(id).get();
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      return Profile(id, data['name'], data['username'], data['phnumber']);
  }



  @override
  Stream<List<Entry>> streamOffers(int number, CardFilter filter) {
    // TODO: implement streamOffers
    Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance.collection('offers').snapshots();
    
    
    return collectionStream.map((offer) => 
      offer.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return Offer(
          data['price'],
          data['id'],
          data['startTime'],
          data['endTime'],
          data['location'],
          data['numberRequests'],
          data['complete']
        );
      }
      ).toList(),
      
    
    );
  }

  @override
  Stream<List<Entry>> streamSales(int number, CardFilter filter) {
    // TODO: implement streamSales
    Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance.collection('sales').snapshots();
    
    
    return collectionStream.map((sale) => 
      sale.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return Sale(
          data['price'],
          data['id'],
          data['startTime'],
          data['endTime'],
          data['location'],
          data['numberRequests'],
          data['complete']
        );
      }
      ).toList(),
      
    
    );

    

    //throw UnimplementedError();
  }

  @override
  void uploadEntry(Entry entry) {
    // TODO: implement uploadEntry

    CollectionReference entries;

    if (entry is Sale) {
      entries = FirebaseFirestore.instance.collection('sales');
    } else {
      entries = FirebaseFirestore.instance.collection('offers');
    }

    entries.add(entry.tojson());
  }
}
