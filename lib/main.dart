import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_material_bank/screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // initialization Future
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error in Firebase Initialisation'),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Study Material Bank',
            home: HomePage(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}
