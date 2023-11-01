import 'package:borla_client/pages/progressdialog.dart';
import 'package:borla_client/pages/signup.dart';
// import 'package:borla_client/pages/smscode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

import '../main.dart';
import 'homepage.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final DatabaseReference _userRef =
    FirebaseDatabase.instance.reference().child('users');
TextEditingController phoneNumberController = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
// Define googleSignIn here

String? phoneNumber;
String? verificationId;
String? smsCode;

Future<void> verifyPhoneNumber() async {
  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
      print('Authentication successful');
    },
    verificationFailed: (FirebaseAuthException e) {
      print('Failed to verify phone number: ${e.message}');
    },
    codeSent: (String? verificationId, int? resendToken) {
      // +233
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Timeout handling if needed
    },
  );
}

Future<User?> _handleGoogleSignIn(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      // Check if the email already exists in the database
      final emailExists =
          await checkIfEmailExistsInDatabase(user.email.toString());

      if (!emailExists) {
        // If the email doesn't exist in the database, write it
        writeEmailToDatabase(user.uid, user.email.toString());
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, "/Homepage", (route) => false);
        // Handle the case where the email already exists in the database
        print('Email already exists in the database');
      }
    }

    return user;
  } catch (error) {
    print(error);
    return null;
  }
}

Future<void> writeEmailToDatabase(String userId, String email) async {
  // Write the email to the database under the user's ID
  _userRef.child(userId).set({'email': email});
}

Future<bool> checkIfEmailExistsInDatabase(String email) async {
  DatabaseEvent snapshot =
      await _userRef.orderByChild('email').equalTo(email).once();
  var data = snapshot.snapshot.value;

  return data != null;
}

class _signinState extends State<signin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // requestSmsPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 18.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text("Login to continue using the app",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  filled: true,
                  // Set filled to true for a grey background
                  fillColor: Colors.grey[200],
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors.grey), // Set the border color to grey
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors
                            .grey), // Set the border color to grey when focused
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.grey,
                  ),
                  filled: true,

                  // Set filled to true for a grey background
                  fillColor: Colors.grey[200],
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors.grey), // Set the border color to grey
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors
                            .grey), // Set the border color to grey when focused
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 12),
                  child: RichText(
                    text: TextSpan(
                      text: 'Forgotten password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          HapticFeedback.lightImpact();
                          Fluttertoast.showToast(
                            msg: 'Forgotten password! button pressed',
                          );
                        },
                    ),
                  ),
                ),
              ],
            ),
            // Implement Apple sign-in button here using the `flutter_apple_sign_in` package.
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF169F00)),
                  onPressed: () {
                    // sendVerificationCode();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SMSCodeInputScreen("verificationId"),
                    //   ),
                    // );
                    // _sendVerificationCode();

                    loginAndAuthenticateUser(context);
                    // Implement Firebase email/password sign-in logic here
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'New User? Sign up',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signup(),
                            ),
                          );
                          HapticFeedback.lightImpact();
                          // Fluttertoast.showToast(
                          //   msg:
                          //   '',
                          // );
                        },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            //
            // ElevatedButton(
            //   onPressed: () {
            //     _handleGoogleSignIn(context);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(
            //           30.0), // Adjust the value to change the roundness
            //     ),
            //   ),
            //   child: Container(
            //     width: 20.0, // Adjust the width as needed
            //     height: 48.0, // Adjust the height as needed
            //     child: Image.asset(
            //       'assets/images/logo.png',
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // final FirebaseAuth _aut= FirebaseAuth.instance;

  final Random random = Random();

  // void requestSmsPermission() async {
  //   if (await Permission.sms.request().isGranted) {
  //     // You have the SEND_SMS permission.
  //   } else {
  //     // You don't have the SEND_SMS permission. Show a rationale and request the permission.
  //     if (await Permission.sms.request().isPermanentlyDenied) {
  //       // The user has permanently denied the permission.
  //       // You may want to navigate them to the app settings.
  //       openAppSettings();
  //     } else {
  //       // The user has denied the permission but not permanently.
  //       // You can request the permission again.
  //       requestSmsPermission();
  //     }
  //   }
  // }
  //
  // void sendVerificationCode() {
  //   final int verificationCode = random.nextInt(900000) + 100000;
  //   final String message = 'Your verification code is: $verificationCode';
  //
  //   sendMS(message);
  //   // registerNewUser(context);
  // }
  String? _verificationCode;

  // Future<void> sendMS(String message) async {
  //   List<String> recipients = [phoneNumberController.text];
  //   print("rarrr" + '${recipients}');
  //   print("message" + '${message}');
  //   try {
  //     await sendSMS(
  //       message: message,
  //       recipients: recipients,
  //       sendDirect: true, // Set this to true for immediate sending
  //     );
  //
  //     // Show a toast message to indicate success.
  //     Fluttertoast.showToast(
  //       msg: "Verification code sent!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //
  //     // Navigate to the verification screen with the verification code.
  //     Navigator.pushNamed(
  //       context,
  //       '/verify',
  //       arguments: _verificationCode.toString(),
  //     );
  //   } catch (error) {
  //     // Show a toast message for the error.
  //     Fluttertoast.showToast(
  //       msg: "Failed to send verification code.",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   }
  // }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Logging you ,Please wait.",
          );
        });

    Future signInWithEmailAndPassword(String email, String password) async {
      try {
        UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
            email: emailcontroller.text.trim(), password: emailcontroller.text.trim());
        User? user = result.user;
        return _firebaseAuth;
      } catch (error) {
        print(error.toString());
        return null;
      }
    }

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailcontroller.text.trim(),
                password: passwordcontroller.text.trim())
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());

     if (clients != null) {
        Navigator.of(context).pushNamed("/Homepage");

        displayToast("Logged-in ", context);
      } else {
        displayToast("Error: Cannot be signed in", context);
      }
    } catch (e) {
      // handle error
    }
  }

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);

// user created
  }
//
}
