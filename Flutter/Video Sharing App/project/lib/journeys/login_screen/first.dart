import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_sharing_app/journeys/homepage/homepage.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  bool otpSent = false;
  String? otp;
  String? verificationId;
  int? resendToken;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            //textfied to get the use input into controller
            TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            //submit button that will get phone number into variavle
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  otpSent = true;
                });
                String phoneNumber =
                    _phoneNumberController.text; // Get the user input

                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: "+91" + phoneNumber,
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (Id, Token) {
                    print("verificationId is ${verificationId}");
                    setState(() {
                      verificationId = Id;
                    });
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );

                print('User entered phone number: $phoneNumber');
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 8.0),
            Visibility(
                visible: otpSent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),

                    //textfied to get the use input into controller
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _otpController,
                      decoration: const InputDecoration(
                        hintText: 'Enter OTP received',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        print("VerificationId is ${verificationId}");

                        String smsCode = _otpController.text;
                        try {
                          // Create a PhoneAuthCredential with the code
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId!,
                                  smsCode: smsCode);

                          // Sign the user in (or link) with the credential
                          await auth
                              .signInWithCredential(credential)
                              .then((value) async {
                            print("signin success. here's user credentials");
                            print(value);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                "userPhone", value.user!.phoneNumber!);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()),
                                (route) => false);
                          });
                        } catch (e) {
                          print("something went wrong. Was your otp correct? ");
                          print(e);
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
