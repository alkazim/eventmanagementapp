import 'package:eventmanagementapp/Edit%20pages/EditBdayTemplate.dart';
import 'package:eventmanagementapp/Event%20Templates/BusinessSeminar.dart';
import 'package:eventmanagementapp/Event%20Templates/graduation%20template.dart';
import 'package:eventmanagementapp/Login%20page.dart';
import 'package:eventmanagementapp/RegisterNewEvent.dart';
import 'package:eventmanagementapp/Signup.dart';
import 'package:eventmanagementapp/Event%20Templates/WeddingCardTemplate.dart';
import 'package:eventmanagementapp/bdaydesigns.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Edit pages/Edit WeddingCeremony.dart';
import 'HomeScreen.dart';
import 'Event Templates/bday template.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyCtsY4Esn5AP-5FPlCL8faIAdwC6CRS6m4',
          appId: '1:608663265453:android:ca023b9ab4647cfa226624',
          messagingSenderId: '608663265453',
          projectId: 'event-management-app-beaa6',
        ),
      );
    } catch (e) {
      print("Error in Firebase initialization: $e");
      return;
    }
  }

  // final prefs = await SharedPreferences.getInstance();
  // String? userId = prefs.getString('UserId');
  // String initialRoute =
  // (userId != null && userId.isNotEmpty) ? 'Home Screen' : 'Login Page';
  // print("Initial Route: $initialRoute");

  // runApp(MyApp(initialRoute: initialRoute));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final String initialRoute;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      // initialRoute: initialRoute,
      routes: {
        'Login Page': (context) => LoginPage(),
        'Signup Page': (context) => Signup(),
        'Home Screen': (context) => Homescreen(),
        'AddNewEvent':(context)=> Registernewevent(),
        'Bday Template':(context)=>BdayTemplate(),
        'Wedding Template':(context)=>WeddingCardTemplate(),
        'Seminar Template':(context)=>Businessseminar(),
        'Graduation Template':(context)=>GraduationTemplate(),
        'Edit Bday Template':(context)=> Editbdaytemplate(),
        'Edit Wedding Template':(context)=>EditWeddingCeremony()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
