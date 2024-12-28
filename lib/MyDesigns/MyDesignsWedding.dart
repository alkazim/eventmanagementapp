import 'dart:ui';
import 'dart:typed_data'; // For using Uint8List
import 'dart:ui' as ui; // For image manipulation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart'; // gal package for saving images
import 'package:permission_handler/permission_handler.dart'; // For handling permissions


class Mydesignswedding extends StatelessWidget {
  Mydesignswedding({super.key});

  final CollectionReference Wedding =
      FirebaseFirestore.instance.collection('Wedding');
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
            icon: Icon(Icons.arrow_back_ios)),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Text(
              "My Designs",
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF3d466b),
                  fontFamily: 'Cinzel',
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        backgroundColor: Color(0xFFf0ecff), // appBar color
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: (){
                saveImageToGallery();
              }, child: Text("Download",)),
        ),
      ),
      backgroundColor: Color(0xFFf0ecff),
      body: StreamBuilder(
          stream: Wedding.where('Mail',isEqualTo:mail ).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error occurred: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
              final wedlist = documentSnapshot.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 450,
                              width: 350,
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'lib/assets/Wedding Card Template 2.jpg'),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 90),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Wedding Ceremony",
                                            style: TextStyle(
                                                fontFamily: 'CurlyThin',
                                                fontSize: 21,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("We invite your pleasure to come  ",
                                              style: TextStyle(
                                                  fontFamily: 'TimesNewRoman')),
                                          Text("to the wedding ceremony of ",
                                              style: TextStyle(
                                                  fontFamily: 'TimesNewRoman')),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            wedlist['Bride'],
                                            style: TextStyle(
                                                fontFamily: 'CurlyThin',
                                                fontSize: 24),
                                          ),
                                          Text("&",
                                              style: TextStyle(
                                                  fontFamily: 'CurlyThin',
                                                  fontSize: 24)),
                                          Text(
                                            wedlist['Groom'],
                                            style: TextStyle(
                                                fontFamily: 'CurlyThin',
                                                fontSize: 24),
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 9.0,top: 0.5),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 83),
                                                  child: Text(
                                                    wedlist['Day'],
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    wedlist['Date'],
                                                    style: TextStyle(
                                                        fontFamily: 'CurlyItalic',
                                                        fontSize: 25),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 20.0),
                                                  child: Text("AT ${wedlist['Time']}",
                                                      style: TextStyle(fontSize: 12)),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            wedlist['Month'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'TimesNewRoman'),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "123 Anywhere St., Ernakulam ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'TimesNewRoman'),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 350,
                              // height: 160,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'lib/assets/White and Blue Floral Wedding Reception Card edited.jpg'),
                                      fit: BoxFit.cover),
                                  color: Color(0xFF6b7c98),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12))),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Event Highlights :",
                                      style: TextStyle(fontFamily: 'TimesNewRoman'),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(wedlist['Event Highlights'],
                                        style: TextStyle(fontFamily: 'TimesNewRoman'))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } //elseif
            else {
              return Center(child: Text("No Designs are available"));
            }
          } //builder
          ),
    );
  }
}
