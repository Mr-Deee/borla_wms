import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {

  final referenceDatabase = FirebaseDatabase.instance.reference().child('ClientRequest');
  List<Map<dynamic, dynamic>> lists = [];

  @override
  void initState() {
    super.initState();
    // _getClientRequests();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Page"),),


      body: Column(children: [
        Row(children: [
          ListView.builder(
            itemCount: lists.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(lists[index]['requestTitle']),
                subtitle: Text(lists[index]['requestDescription']),
              );
            },
          ),
        ],)
      ],),
    );
  }

  void _getClientRequests() {
    clientRequestRef.once().then((DatabaseEvent? snapshot) {
      final Map<dynamic, dynamic>? values = snapshot as Map<dynamic, dynamic>?;

      if (values != null) {
        // lists = values.map((key, value)).toList();
      }

      setState(() {});
    });
  }

}
