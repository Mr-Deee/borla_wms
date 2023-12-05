import 'package:borla_client/Model/Client.dart';
import 'package:borla_client/Model/appstate.dart';
import 'package:borla_client/pages/Aboutpage.dart';
import 'package:borla_client/pages/Profilepage.dart';
import 'package:borla_client/pages/homepage.dart';
import 'package:borla_client/pages/signin.dart';
import 'package:borla_client/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    ),   ChangeNotifierProvider<WMS>(
      create: (context) => WMS(),
    ),

// ),
    ChangeNotifierProvider<helper>(
      create: (context) => helper(),
    ),

    ChangeNotifierProvider<otherUsermodel>(
      create: (context) => otherUsermodel(),
    ),

    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
    ),
  ],child: MyApp()));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Handle the notification here when the app is in the background.
}


_firebaseMessaging.configure(
onMessage: (Map<String, dynamic> message) async {
print("onMessage: $message");
// Handle the notification when the app is in the foreground.
},
onLaunch: (Map<String, dynamic> message) async {
print("onLaunch: $message");
// Handle the notification when the app is launched from terminated state.
},
onResume: (Map<String, dynamic> message) async {
print("onResume: $message");
// Handle the notification when the app is resumed from background.
},
);
}
}
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.uid;
DatabaseReference  clientRequestRef = FirebaseDatabase.instance.ref().child("ClientRequest");
DatabaseReference WastemanagementRef= FirebaseDatabase.instance.ref().child("WMS").child(uid!).child("new WMS");
DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference WMSDB = FirebaseDatabase.instance.ref().child("WMS");
DatabaseReference WMSDBtoken = FirebaseDatabase.instance.ref().child("WMS").child(uid!);
DatabaseReference WMSAvailable = FirebaseDatabase.instance.ref().child("availableWMS").child(uid!);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorlApp_wms',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
        initialRoute:
        FirebaseAuth.instance.currentUser == null ? '/SignIn' : '/Homepage',
        routes: {
          "/SignUP": (context) => signup(),
          "/About": (context) => AboutPage(),
          // "/OnBoarding": (context) => ,
          "/SignIn": (context) =>signin(),
          "/Profile": (context) =>Profilepg(),
          "/Homepage": (context) => homepage(),
          //    "/addproduct":(context)=>addproduct()
        }
    );
  }
}


