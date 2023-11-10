import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  // AboutPage({});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  double _width = 70;

  @override
  Widget build(BuildContext context) {
    // final bool isColapsed;
    // createIconMarker();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon or logo
              // Image.asset('assets/app_logo.png', width: 100, height: 100),

              // App name and version
              Center(
                child: Container(
                  width: 239.0, // Adjust the width as needed
                  height: 120, // Adjust the height as needed
                  child: Image.asset(
                    'assets/images/wms.png',
                  ),),
              ),
              Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 8),
              ),

              // Description or information about the app
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'This is With Borla tech app, anyone enrolled on the app can request for pick up of their waste either from their homes,workplace, marketplaces etc. '
                      'and immediately your request will be sent to the waste management services.'
                      'The Google API feature will help waste management services locate you with easy.',
                  // 'It's designed to showcase Flutter development skills.',
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Divider(
                thickness: 4,
                color: Colors.blue,
              ),
              Row(children: [
                SizedBox(height: 44,),
                Text(
                  'TeamMembers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  SizedBox(
                    height:194,
                    child: Card(
                        color: Colors.white,

                        child: Column(children: [
                          Center(
                            child: Container(
                              width: 109.0, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                              child: Image.asset(
                                'assets/images/ics1.png',
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Dickson Junior\n Addai-Badu",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Text(""),
                        ])),
                  ),
                  SizedBox(
                    height:194,
                    child: Card(
                      color: Colors.white,
                        child: Column(children: [
                          Center(
                            child: Container(
                              width: 109.0, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                              child: Image.asset(
                                'assets/images/ics2.png',
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Daniel Narterh",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Text("Lead Developer",style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12),),
                        ])),
                  ),
                  SizedBox(
                    height:194,
                    child: Card(
                        color: Colors.white,

                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Kofi Biney",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Text("Web Developer",style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12),)
                        ])),
                  ),
                ]),
              ),
              // Developer information


            ],
          ),
        ),
      ),
    );
  }
}