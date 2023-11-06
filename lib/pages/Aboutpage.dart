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
              Text(
                'Borla Client',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                thickness: 3,
                color: Colors.blue,
              ),
              Row(children: [
                Text(
                  'TeamMembers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Joseph Dickson",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                        ),
                        Text("President"),
                      ])),
                  Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Daniel Narterh",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                        ),
                        Text("Lead Developer"),
                      ])),
                  Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "BINEY..",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                        ),
                        Text("Lead Developer"),
                      ])),
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