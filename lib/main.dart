import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/views/maps/maps_view.dart';
import 'package:flutter_maps/views/phone_login/phone_login_view.dart';

Widget initialRoute;

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = PhoneLoginView();
    } else {
      initialRoute = const MapsView();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return initialRoute;
  }
}
