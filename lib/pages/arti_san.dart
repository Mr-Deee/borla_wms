import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Arti_san extends ChangeNotifier
{
  String ?name;
  String ?phone;
  String ?email;
  String ?id;
  String ?servicetype;
  String ?education;
  String ?plate_number;
  String ?profilepicture;

  Arti_san({this.name, this.phone, this.email, this.id, this.servicetype, this.education, this.plate_number, this.profilepicture,});

  Arti_san.fromSnapshot(DataSnapshot dataSnapshot) {
    final data = Map<String, dynamic>.from((dataSnapshot).value as Map);


      id= data['uid'];
      phone= data["phone"];
      email= data["email"];
      name= data["name"];
     // profilepicture= data["profilepicture"].toString();
    servicetype= data["Service Type"];
    education= data["Education Background"];

     // plate_number=data["car_details"]["plate_number"];

  }
}
