import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_feature_firebase/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CloudFirestoreSearch(),
    ),
  );
}
