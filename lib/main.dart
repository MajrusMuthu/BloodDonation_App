// ignore_for_file: unused_import, prefer_const_constructors
import 'package:bloodapp/Blood_App/Home_Page.dart';
import 'package:bloodapp/Blood_App/Input_Page.dart';
import 'package:bloodapp/Blood_App/Update.dart';
import 'package:bloodapp/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      routes: {
        '/home': (context) => HomePage(),
        '/add': (context) => InputPage(),
        '/Update': (context) => Update()
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
