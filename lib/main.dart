import 'package:borla_client/Model/Client.dart';
import 'package:borla_client/pages/homepage.dart';
import 'package:borla_client/pages/signin.dart';
import 'package:borla_client/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'Assistant/helper.dart';
import 'Model/Users.dart';
import 'Model/otherUserModel.dart';
import 'appData.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
    ),
    ChangeNotifierProvider<Users>(
      create: (context) => Users(),
    ),
    ChangeNotifierProvider<WMS>(
      create: (context) => WMS(),
    ),

// ),
    ChangeNotifierProvider<helper>(
      create: (context) => helper(),
    ),

    ChangeNotifierProvider<otherUsermodel>(
      create: (context) => otherUsermodel(),
    ),
  ], child: MyApp()));
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.uid;
DatabaseReference clientRequestRef =
    FirebaseDatabase.instance.ref().child("ClientRequest");
DatabaseReference WastemanagementRef =
    FirebaseDatabase.instance.ref().child("WMS").child(uid!).child("new WMS");
DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference WMSDB = FirebaseDatabase.instance.ref().child("WMS");
DatabaseReference WMSDBtoken =
    FirebaseDatabase.instance.ref().child("WMS").child(uid!);
DatabaseReference WMSAvailable = FirebaseDatabase.instance
    .ref()
    .child("availableWMS")
    .child(currentfirebaseUser!.uid);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BorlApp_wms',
        theme: ThemeData(
          // ban
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/SignIn' : '/Homepage',
        routes: {
          "/SignUP": (context) => signup(),
          // "/OnBoarding": (context) => ,
          "/SignIn": (context) => signin(),
          "/Homepage": (context) => homepage(),
          //    "/addproduct":(context)=>addproduct()
        });
  }
}
