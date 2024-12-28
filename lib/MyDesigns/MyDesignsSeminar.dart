import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data'; // For using Uint8List
import 'dart:ui' as ui; // For image manipulation
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart'; // gal package for saving images
import 'package:permission_handler/permission_handler.dart'; // For handling permissions

class MyDesignsSeminar extends StatelessWidget {
  MyDesignsSeminar({super.key});

  final CollectionReference Seminar = FirebaseFirestore.instance.collection('Seminar');
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
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined))),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  saveImageToGallery();
                }, child: Text("Download",)),
          ),
        ),
        body: StreamBuilder(
        stream: Seminar.where('User Mail', isEqualTo: mail).snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error occurred: ${snapshot.error}'));
    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
      final seminarlist = documentSnapshot.data() as Map<String, dynamic>;
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RepaintBoundary(
              key: _globalKey,
              child: Column(
                children: [
                  Container(
                    height: 500,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/Seminar Template new.jpg'),
                            fit: BoxFit.cover)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                                seminarlist['Company Name'],
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'TimesNewRoman'),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "BUSINESS SEMINAR",
                            style: TextStyle(
                                fontSize: 34, fontFamily: 'TimesNewRoman'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text("TOPIC : ",style: TextStyle(fontSize: 16,fontFamily: 'TimesNewRoman'),),
                            Text(
                              seminarlist['Title'],
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'TimesNewRoman'),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 40),
                                  child: Container(
                                    height: 60,
                                    width: 165,
                                    //color: Colors.blue,
                                    child: Text(
                                      seminarlist['Text1'],
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'TimesNewRoman'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 17),
                                  child: Container(
                                    height: 100,
                                    width: 165,
                                    // color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          "Topic Highlights : ",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Text(
                                            seminarlist['Topic Highlights'],
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'TimesNewRoman'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 12),
                                  child: Container(
                                    height: 100,
                                    width: 165,
                                    //color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            seminarlist['Date'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontFamily: 'TimesNewRoman'),
                                          ),
                                          Text(
                                            seminarlist['Time'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'TimesNewRoman'),
                                          ),
                                          Text(seminarlist['Location'], style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'TimesNewRoman'),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6, bottom: 10, top: 49),
                                  child: Container(
                                    height: 22,
                                    width: 144,
                                    // color: Colors.yellow,
                                    child: Center(child: Text("SPEAKERS :",
                                      style: TextStyle(
                                          fontFamily: 'TimesNewRoman'),)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: 150,
                                    child: Text(seminarlist['Speakers'],style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'TimesNewRoman'),),
                                    decoration: BoxDecoration(
                                       // color: Colors.orange,
                                        borderRadius: BorderRadius.circular(12)
                                        // image: DecorationImage(
                                        //     image: AssetImage(
                                        //         'lib/assets/Corporate_Event.jpg'),
                                        //     fit: BoxFit.cover)
                                    ),
                                  ),
                                ),
                                //SizedBox(height: 7,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    height: 120,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.teal,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'lib/assets/Corporate_Event.jpg'),
                                            fit: BoxFit.cover)
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                // color: Colors.white,
                                height: 20,
                                // width: 70,
                                child: Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.white,
                                      size: 16,),
                                    SizedBox(width: 5,),
                                    Text(seminarlist['Mobile'], style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: 'TimesNewRoman'),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                // color: Colors.white,
                                height: 20,
                                // width: 100,
                                child: Row(
                                  children: [
                                    Icon(Icons.language, color: Colors.white,
                                      size: 16,),
                                    SizedBox(width: 5,),
                                    Text("www.ingoude.com", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: 'TimesNewRoman'),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }else
      {
        return Center(child: Text("No Designs are available"));
      }
    },)
    );
    }
  }
