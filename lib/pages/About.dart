import 'package:flutter/material.dart';
import 'dart:async';

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
              Image.asset('assets/app_logo.png', width: 100, height: 100),

              // App name and version
              Text(
                'Your App Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 16),
              ),

              // Description or information about the app
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'This is a Flutter app that does amazing things. ',
                  // 'It's designed to showcase Flutter development skills.',
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),

              // Developer information
              Text(
                'Developed by Your Name',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Email: your@email.com',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
