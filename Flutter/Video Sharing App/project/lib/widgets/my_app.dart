import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_sharing_app/journeys/homepage/upload_video_screen/upload_video_page.dart';
import 'package:video_sharing_app/journeys/login_screen/first.dart';

import '../journeys/homepage/homepage.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

//convert to a worker
  bool? loggedIn;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> checkUserLoggedIn() async {
    await auth.authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn = false;
        // User is not signed in.
      } else {
        loggedIn = true;
        // User is signed in.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'video sharing app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<void>(
        future: checkUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return loggedIn! ? MyHomePage() : First();
          }
        },
      ),
    );
  }
}
