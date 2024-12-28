import 'package:eventmanagementapp/Edit%20pages/Edit%20Graduation%20Party.dart';
import 'package:eventmanagementapp/Edit%20pages/Edit%20ShopInauguration.dart';
import 'package:eventmanagementapp/Edit%20pages/EditBdayTemplate.dart';
import 'package:eventmanagementapp/Edit%20pages/EditBusinessSeminar.dart';
import 'package:eventmanagementapp/Event%20Templates/BusinessSeminar.dart';
import 'package:eventmanagementapp/Event%20Templates/ShopInaugration%20Template.dart';
import 'package:eventmanagementapp/Event%20Templates/graduation%20template.dart';
import 'package:eventmanagementapp/IntroScreen.dart';
import 'package:eventmanagementapp/Login%20page.dart';
import 'package:eventmanagementapp/MyDesigns/My%20DesignsBday.dart';
import 'package:eventmanagementapp/MyDesigns/MyDesignShopInauguration.dart';
import 'package:eventmanagementapp/MyDesigns/MyDesigns.dart';
import 'package:eventmanagementapp/MyDesigns/MyDesignsSeminar.dart';
import 'package:eventmanagementapp/MyDesigns/MyDesignsWedding.dart';
import 'package:eventmanagementapp/RegisterNewEvent.dart';
import 'package:eventmanagementapp/Signup.dart';
import 'package:eventmanagementapp/Event%20Templates/WeddingCardTemplate.dart';
import 'package:eventmanagementapp/SplashScreen.dart';
import 'package:eventmanagementapp/bdaydesigns.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Edit pages/Edit WeddingCeremony.dart';
import 'HomeScreen.dart';
import 'Event Templates/bday template.dart';
import 'MyDesigns/MyDesignGraduation.dart';
import 'MyDesigns/bdayDesignTest.dart';

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

  final prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('UserId');
  String initialRoute =
  (userId != null && userId.isNotEmpty) ? 'Home Screen' : 'Login Page';
  print("Initial Route: $initialRoute");
  runApp(MyApp(initialRoute: initialRoute));

 // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
     initialRoute: initialRoute,
     // initialRoute: 'Splash Screen',//******* enable splash screen here ******
      routes: {
        'Login Page': (context) => LoginPage(),
        'Signup Page': (context) => Signup(),
        'Home Screen': (context) => Homescreen(),
        'AddNewEvent':(context)=> Registernewevent(),
        'Bday Template':(context)=>BdayTemplate(),
        'Wedding Template':(context)=>WeddingCardTemplate(),
        'Seminar Template':(context)=>Businessseminar(),
        'Graduation Template':(context)=>GraduationTemplate(),
        'Shop Inauguration Template':(context)=>ShopInaugrationTemplate(),
        'Edit Bday Template':(context)=> Editbdaytemplate(),
        'Edit Wedding Template':(context)=>EditWeddingCeremony(),
        'Edit Inauguration template':(context)=>EditShopInauguration(),
        'My Designs':(context)=>MyDesigns(),
        'Splash Screen':(context)=>SplashScreen(),
        'Intro Screen':(context)=>IntroScreen(),
        'MyDesignsSeminar':(context)=>MyDesignsSeminar(),
        'MyDesignGraduation':(context)=>MyDesignGraduation(),
        'MyDesignShopInauguration':(context)=>MyDesignShopInauguration(),
        'EditBusinessSeminars':(context)=>EditBusinessSeminar(),
        'EditGraduation':(context)=>EditGraduation(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
