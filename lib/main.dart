import 'package:borla_client/pages/homepage.dart';
import 'package:borla_client/pages/signin.dart';
import 'package:borla_client/pages/signup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const MyApp());
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.uid;
DatabaseReference  clientRequestRef = FirebaseDatabase.instance.ref().child("Binpickup");
DatabaseReference WastemanagementRef= FirebaseDatabase.instance.ref().child("WMS").child(uid!).child("new WMS");
DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference WMSDB = FirebaseDatabase.instance.ref().child("WMS");
DatabaseReference WMSAvailable = FirebaseDatabase.instance.ref().child("availableWMS");
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorlApp_wms',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        initialRoute:
        FirebaseAuth.instance.currentUser == null ? '/SignIn' : '/Homepage',
        routes: {
          "/SignUP": (context) => signup(),
          // "/OnBoarding": (context) => ,
          "/SignIn": (context) =>signin(),
          "/Homepage": (context) => homepage(),
          //    "/addproduct":(context)=>addproduct()
        }
    );
  }
}


