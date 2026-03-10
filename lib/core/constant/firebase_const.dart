import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{
  FirebaseFirestore fdb=FirebaseFirestore.instance;
  
  CollectionReference get projects=>fdb.collection('PROJECT');
}

