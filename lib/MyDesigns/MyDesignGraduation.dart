import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data'; // For using Uint8List
import 'dart:ui' as ui; // For image manipulation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart'; // gal package for saving images
import 'package:permission_handler/permission_handler.dart'; // For handling permissions


class MyDesignGraduation extends StatelessWidget {
  MyDesignGraduation({super.key});

  final CollectionReference Graduation =
      FirebaseFirestore.instance.collection('Graduation');
  String? mail = FirebaseAuth.instance.currentUser!.email;

  final GlobalKey _globalKey = GlobalKey(); // GlobalKey for the container
  Future<void> requestStoragePermission() async {
    print("Storage Permission started");
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("Permission granted");
    } else if (status.isDenied) {
      print("Permission denied");
      openAppSettings(); // Direct user to settings to enable permission
    } else {
      print("Permission not granted yet");
    }
    print("Storage permission ended");
  }

  Future<void> saveImageToGallery() async {
    print("Save Image to Gallery started");

    // Request permission
    await requestStoragePermission();

    try {
      // Capture the widget as a bitmap after the widget is fully built
      await Future.delayed(Duration(milliseconds: 100)); // Add a slight delay
      RenderRepaintBoundary? boundary =
      _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      // Null check to ensure boundary is available
      if (boundary != null) {
        ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Capture the image

        // Convert the image to bytes
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List bytes = byteData!.buffer.asUint8List();

        // Save the image to the gallery
        await Gal.putImageBytes(bytes); // Save the image bytes
        print("Image saved successfully!");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   duration: Duration(seconds: 4),
        //   behavior: SnackBarBehavior.floating,
        //   content: Text("Image saved to your gallery"),
        // ));
      } else {
        print("Failed to capture: RenderRepaintBoundary is null.");
      }
    } catch (e) {
      print('Failed to capture the widget: $e');
    }
    print("Save image to gallery ended");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Designs",
          style: TextStyle(
              fontSize: 28,
              color: Color(0xFF3d466b),
              fontFamily: 'Cinzel',
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: Color(0xFFf0ecff),
      ),
      body: StreamBuilder(
          stream: Graduation.where('Mail', isEqualTo: mail).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error occurred: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
              final gradlist = documentSnapshot.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 510,
                          width: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'lib/assets/graduation template 1.jpeg',
                                  ),
                                  fit: BoxFit.cover)),
                          child: Center(
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 26),
                                      child: Container(
                                        //width: 100,
                                        //height: 20,
                                        child: Text(
                                          "PLEASE JOIN US TO CELEBRATE",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                        // color: Colors.teal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 45),
                                      child: Container(
                                        //height: 70,
                                        //width: 150,
                                        //color: Colors.teal,
                                        child: Column(
                                          children: [
                                            Text(
                                              "GRADUATION",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'TimesNewRoman'),
                                            ),
                                            Text(
                                              "PARTY",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'TimesNewRoman'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: CircleAvatar(
                                        radius: 65,
                                        backgroundImage: AssetImage(
                                            'lib/assets/graduation profile pic.jpg'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 17),
                                      child: Container(
                                        //height: 10,
                                        //width: 20,
                                        // color: Colors.teal,
                                        child: Text(
                                          "OF",
                                          style: TextStyle(
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      //color: Colors.teal,
                                      child: Text(
                                        gradlist['Name'],
                                        style: TextStyle(
                                            fontFamily: 'TimesNewRoman',
                                            fontSize: 24),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("--- "),
                                          Text(
                                            gradlist['Date'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'TimesNewRoman'),
                                          ),
                                          Text(" ---"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        gradlist['Time'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'TimesNewRoman'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        gradlist['Location'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'TimesNewRoman'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("No Designs are available"));
            }
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                saveImageToGallery();
              },
              child: Text(
                "Download",
              )),
        ),
      ),
    );
  }
}
