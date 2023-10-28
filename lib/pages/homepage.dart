import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_fonts/google_fonts.dart';
import '../Assistant/assistantmethods.dart';
import '../Assistant/helper.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Model/Users.dart';
import '../Model/otherUserModel.dart';
import '../configMaps.dart';
import '../main.dart';
import '../notifications/pushNotificationService.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_geofire/flutter_geofire.dart';

import 'Requestsfolder.dart';
import 'arti_san.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng (5.614818, -0.205874),
    zoom: 24.4746,
  );

  @override
  State<homepage> createState() => _homepageState();
}
loc.Location location =
loc.Location();
class _homepageState extends State<homepage> {

  String? currentSelectedValue;


  final location = TextEditingController();

  @override
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? newGoogleMapController;

  var geoLocator = Geolocator();

  String driverStatusText = "Go Online ";
  User? currentfirebaseUser;
  Color driverStatusColor = Colors.white70;

  bool isDriverAvailable = false;
  bool isDriverActivated = false;

  Set<Marker> markersSet = {};
  Position? _currentPosition;
  String? _currentAddress;
  String ArtisanStatusText = "Go Online ";

  Color ArtisanStatusColor = Colors.white70;

  double bottomPaddingOfMap = 0;
   //explicit reference to the Location class

  // Future _checkGps() async {
  //   if (!await location.serviceEnabled()) {
  //     location.requestService();
  //   }
  // }

  Future<void> requestLocationPermission() async {
    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;

    bool isLocation =
        serviceStatusLocation == Permission.location.serviceStatus.isEnabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  // List<ReqModel> rModel = [];
  Color _textColor = Colors.black;





  getartisanType() {
  WastemanagementRef
      .child(currentfirebaseUser!.uid)
      .child("service_type")
      .once()
      .then((value) {
  if (value != null) {
  print("Info got");
  setState(() {
  rideType = value.toString();
  });
  }
  });
  }


  getCurrentArtisanInfo() async {
  currentfirebaseUser = await FirebaseAuth.instance.currentUser;
  WMSDB.child(currentfirebaseUser!.uid).once().then((event) {
  print("value");
  if (event.snapshot.value != null) {
  artisanInformation = Arti_san.fromSnapshot(event.snapshot);
  }

  PushNotificationService pushNotificationService = PushNotificationService();
  pushNotificationService.initialize(context);
  pushNotificationService.getToken();
  });

  PushNotificationService pushNotificationService = PushNotificationService();
  pushNotificationService.initialize(context);
  pushNotificationService.getToken();

  // AssistantMethod.retrieveHistoryInfo(context);
  //getRatings();
  getartisanType();
  }

  // Position? _currentPosition;
  // String? _currentAddress;
  String WMSStatusText = "Go Online ";

  Color WMSStatusColor = Colors.white70;
  bool isArtisanAvailable = false;
  bool isArtisanActivated = false;

  @override
  void initState() {
  setState(() {
  Provider.of<helper>(context, listen: false).getCurrentLocation();
  Provider.of<helper>(context, listen: false).getAddressFromLatLng();
  });


  super.initState();
  AssistantMethod.getCurrentOnlineUserInfo(context);
  // AssistantMethod.getCurrentOnlineOtherUserInfo(context);
  //getPicture();
    // _checkGps();
    requestLocationPermission();
  AssistantMethod.getCurrentrequestinfo(context);
  AssistantMethod.obtainTripRequestsHistoryData(context);
  getCurrentArtisanInfo();

  }



  final List<String> imageList = [
  "assets/images/barber.png",
  "assets/images/carpenter.png",
  "assets/images/mechanic.png",

  //'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];


  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
  var searchIng = clientRequestRef.orderByChild("service_type").equalTo(Provider.of<otherUsermodel>(context, listen: false).otherinfo?.Service);
  String? occupation= Provider.of<otherUsermodel>(context).otherinfo?.Service;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  Size size = MediaQuery.of(context).size; //check the size of device
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark; //

  return Scaffold(
  backgroundColor: Colors.cyan,
  // drawer: CustomDrawer(),
  appBar: PreferredSize(
  preferredSize: const Size.fromHeight(40.0), //appbar size
  child: AppBar(
  elevation: 0,
  shadowColor: Colors.transparent,
  backgroundColor:
  isDarkMode ? const Color(0xff06090d) : Colors.black,
  leading: Builder(
  builder: (context) => IconButton(
  icon: new Icon(
  Icons.drag_handle_outlined,
  color: isDarkMode
  ? Colors.white
      : Colors.black, //icon bg color
  size: size.height * 0.025,
  ),
  onPressed: () => Scaffold.of(context).openDrawer(),
  )),
  automaticallyImplyLeading: false,
  titleSpacing: 0,
  leadingWidth: size.width * 0.15,
  title: Text("The Crafty",
  style: GoogleFonts.poppins(
  color: Colors.black,
  fontSize: size.width * 0.06,
  fontWeight: FontWeight.bold,
  )),
  centerTitle: true,
  actions: <Widget>[
  Padding(
  padding: EdgeInsets.only(
  right: size.width * 0.05,
  ),
  ),
  ],
  ),
  ),
  body: SingleChildScrollView(
  child: Column(children: [
  if (Provider.of<Users>(context).userInfo?.firstname != null)
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

  children: [
  Column(
  children: [
  Padding(
  padding: EdgeInsets.all(12.0),
  child: Text(
  'Hi, ' +
  Provider.of<Users>(context).userInfo!.firstname! +
  "!",
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  ),
  ],
  ),

  Column(
  children: [
  Padding(
  padding: EdgeInsets.only(top: 16.0,left:70.0,right:20.0),
  child: Switch(
  value: isSwitched,

  onChanged: (value) async {
  currentfirebaseUser = await FirebaseAuth.instance.currentUser;


  if (isSwitched == false) {
  makeArtisanOnlineNow();
  getLocationLiveUpdates();

  setState(() {
  isSwitched = true;
  });
  displayToast(" Online .", context);
  } else {
  makeArtisanOfflineNow();

  setState(() {
  isSwitched = false;

  ArtisanStatusColor = Colors.white70;
  ArtisanStatusText = "Offline ";
  isArtisanAvailable = false;
  });

  displayToast("offline .", context);
  };

  },

  activeTrackColor: Colors.black38,
  activeColor: Colors.black,



  ),
  ),
  ],
  ),



  // Positioned(
  //   top: 20.0,
  //   left: 0.0,
  //   right: 0.0,
  //   child: Row(
  //
  //       //mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16.0),
  //           child: RaisedButton(
  //             shape: new RoundedRectangleBorder(
  //               borderRadius: new BorderRadius.circular(24.0),
  //             ),
  //             onPressed: () async {
  //               currentfirebaseUser =
  //                   await FirebaseAuth.instance.currentUser;
  //
  //               artisans
  //                   .child(currentfirebaseUser!.uid)
  //                   .child("ArtisanStatus")
  //                   .once()
  //                   .then((event) {
  //                 if (event == "Deactivated") {
  //                   displayToast(
  //                       "Sorry You are not Activated", context);
  //                   ArtisanActivated();
  //                   getLocationLiveUpdates();
  //
  //                   setState(() {
  //                     ArtisanStatusColor = Colors.red;
  //                     ArtisanStatusText = "offline -Deactivated";
  //                     isArtisanAvailable = false;
  //                   });
  //                 } else if (isArtisanAvailable != true) {
  //                   makeArtisanOnlineNow();
  //                   getLocationLiveUpdates();
  //
  //                   setState(() {
  //                     ArtisanStatusColor = Colors.blueAccent;
  //                     ArtisanStatusText = "Online ";
  //                     isArtisanAvailable = true;
  //                   });
  //                   displayToast("you are Online Now.", context);
  //                 } else {
  //                   makeArtisanOfflineNow();
  //
  //                   setState(() {
  //                     ArtisanStatusColor = Colors.white70;
  //                     ArtisanStatusText = "Offline ";
  //                     isArtisanAvailable = false;
  //                   });
  //
  //                   displayToast("you are offline Now.", context);
  //                 }
  //               });
  //             },
  //             color: ArtisanStatusColor,
  //             child: Padding(
  //               padding: EdgeInsets.all(12.0),
  //               child: Row(
  //                 mainAxisAlignment:
  //                     MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     ArtisanStatusText,
  //                     style: TextStyle(
  //                         fontSize: 20.0,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black),
  //                   ),
  //                   Icon(
  //                     Icons.online_prediction,
  //                     color: Colors.black,
  //                     size: 26.0,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         )
  //       ]),
  // ),
  ],
  ),

  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child: SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

  children: [

  FadeInDown(
  delay: const Duration(milliseconds: 1000),
  child: SizedBox(
  height: 160,
  width: 240,
  child: GestureDetector(
  onTap: () {
  // Navigator.of(context).pushAndRemoveUntil(
  // MaterialPageRoute(
  // builder: (context) => EditCrafts()),
  // (Route<dynamic> route) => true);
  },
  child: Card(
  color: Colors.black,
  elevation: 8,
  shadowColor: Colors.black38,
  shape:  RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
  Radius.circular(20),
  ),
  side: BorderSide(width: size.width, color: Colors.white24)),
  child: Column(
  children: [
  Padding(
  padding: const EdgeInsets.all(20.0),
  child: Text('Edit  your Craft',
  style: GoogleFonts.openSans(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
  )),
  ),
  Icon(
  Icons.edit,
  color: Colors.white,
  ),
  ],
  ),
  ),
  ),
  ),
  ),
  FadeInDown(
  delay: const Duration(milliseconds: 1000),
  child: SizedBox(
  height: 160,
  width: 180,
  child: GestureDetector(
  onTap: () {
  // Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(
  //         builder: (context) => Artisan_portfolio()),
  //     (Route<dynamic> route) => true);
  },
  child: Card(
  elevation: 8,
  shadowColor: Colors.black38,
  shape:  RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
  Radius.circular(20),
  ),
  side: BorderSide(

  width: size.width, color: Colors.white24)),
  child: Column(
  children: [
  Padding(
  padding: const EdgeInsets.only(
  top: 50.0, left: 10, right: 10),
  child: Text('Earnings',
  style: GoogleFonts.openSans(
  color: Colors.black,
  //fontWeight: FontWeight.bold,
  fontSize: 20,
  )),
  ),
  Icon(
  Icons.monetization_on_rounded,
  ),
  ],
  ),
  ),
  ),
  ),
  ),

  ]),
  ),
  ),

  SizedBox(height: 30,),
  GestureDetector(
  onTap: (){
  showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => requestsfolder(
  // paymentMethod: widget.clientDetails.payment_method,
  // fareAmount: fareAmount,
  ));


  },
  child: Container(
  child: Column(
  children: [

  Container(
  margin: EdgeInsets.all(15),
  child: CarouselSlider.builder(
  itemCount: imageList.length,
  options: CarouselOptions(
  enlargeCenterPage: true,
  height: 190,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 3),
  reverse: false,
  aspectRatio: 5.0,
  ),
  itemBuilder: (context, i, id) {
  //for onTap to redirect to another screen

  return GestureDetector(
  child: Container(
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  border: Border.all(
  color: Colors.white12,
  )),
  //ClipRRect for image border radius
  child: ClipRRect(
  borderRadius: BorderRadius.circular(15),
  child: Image.asset(

  imageList[i],
  width: 600,
  fit: BoxFit.cover,
  ),
  ),
  ),
  onTap: () {
  var url = imageList[i];
  print(url.toString());
  },
  );
  },
  ),
  ),
  Center(
  child: Text("Requests folder",style: TextStyle(
  fontWeight: FontWeight.bold,color:Colors.black,
  ),),
  ),
  ],
  ),

  height: 300 ,
  width: 340,
  decoration: BoxDecoration(

  color: Colors.black12,
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [ BoxShadow(
  color: Colors.transparent,
  blurRadius: 0.0,
  offset: Offset.zero,
  spreadRadius: 2.0,
  )
  ]

  ),

  ),
  ),

  //if clause for jobs



  const SizedBox(
  height: 10,
  ),
  ]),
  ),
  );
  }

  void makeArtisanOnlineNow() async {
  Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high);
  currentPosition = position;


  Map<String, dynamic> artisanMap = {
  "Profilepicture": Provider.of<Users>(context, listen:false).userInfo!.profilepicture!,
  "client_name" :  Provider.of<Users>(context, listen:false).userInfo!.firstname!  +   Provider.of<Users>(context, listen:false).userInfo!.lastname!,
  "FirstName":Provider.of<Users>(context, listen:false).userInfo!.firstname!,
  "LastName":Provider.of<Users>(context, listen:false).userInfo!.lastname!,
  // "service_type" :Provider.of<otherUsermodel>(context,listen:false).otherinfo!.Service!,
  "client_phone"  :Provider.of<Users>(context,listen:false).userInfo!.phone!,
  // "Experience" :Provider.of<otherUsermodel>(context,listen: false).otherinfo!.Experience!,
  // "Institution": Provider.of<otherUsermodel>(context,listen: false).otherinfo!.Institution!,
  "email":Provider.of<Users>(context,listen:false).userInfo!.email!,
  // "Education":  Provider.of<otherUsermodel>(context,listen:false).otherinfo!.Education!,
  // "Description": Provider.of<otherUsermodel>(context,listen:false).otherinfo!.Description!,
  // "Location":Provider.of<otherUsermodel>(context,listen: false).otherinfo!.location??"",

  };
  WastemanagementRef.set("searching");
  Geofire.initialize("availableArtisans");
  Geofire.setLocation(
  currentfirebaseUser!.uid,
  currentPosition!.latitude,
  currentPosition!.longitude,
  );
  await WMSAvailable.update(artisanMap);

  WastemanagementRef.onValue.listen((event) {});
  }

  void getLocationLiveUpdates() {
  homeTabPageStreamSubscription =
  Geolocator.getPositionStream().listen((Position position) {
  currentPosition = position;

  if (isArtisanAvailable == true) {
  Geofire.setLocation(
  currentfirebaseUser!.uid, position.latitude, position.longitude);
  }

  // LatLng latLng = LatLng(position.latitude, position.longitude);
  // newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
  });
  }

  Future<void> ArtisanActivated() async {
  Geofire.removeLocation(currentfirebaseUser!.uid);
  WastemanagementRef.onDisconnect();
  WastemanagementRef.remove();

  displayToast("Sorry You are not Activated", context);
  }

  void makeArtisanOfflineNow() {
  Geofire.removeLocation(currentfirebaseUser!.uid);
  WastemanagementRef.onDisconnect();
  WastemanagementRef.remove();
  //rideRequestRef= null;
  //return makeDriverOnlineNow();
  // _restartApp();
  }


  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }


}