import 'dart:typed_data'; // For using Uint8List
import 'dart:ui' as ui; // For image manipulation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart'; // gal package for saving images
import 'package:permission_handler/permission_handler.dart'; // For handling permissions

// void main() {
//   runApp(MaterialApp(home: BdayDesignTest()));
// }

class BdayDesignTest extends StatefulWidget {
  const BdayDesignTest({super.key});

  @override
  _BdayDesignTestState createState() => _BdayDesignTestState();
}

class _BdayDesignTestState extends State<BdayDesignTest> {
  bool isButton=true;// for download button
  final GlobalKey _globalKey = GlobalKey(); // GlobalKey for the container

  final CollectionReference Birthday =
  FirebaseFirestore.instance.collection('Birthday');
  String? mail = FirebaseAuth.instance.currentUser!.email;
  String? status;

  // Function to request permission for managing external storage
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

  // Function to capture the widget as an image and save it to the gallery
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          content: Text("Image saved to your gallery"),
        ));
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
            Navigator.pushNamed(context, 'My Designs');
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
      ),
      bottomNavigationBar: isButton?Container(
        height: 50,
        width: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              if(status!='pending')
                {
                  saveImageToGallery();
                }
              else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Design not approved "),
               behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 5),));
              }

              print("Download button pressed");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isButton?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Download",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Icon(Icons.download)
                ],
              ):Container(),
            ),
          ),
        ),
      ):Container(),
      body: StreamBuilder(
        stream: Birthday.where('Email',isEqualTo: mail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            isButton=true;
            final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
            final bdayList = documentSnapshot.data() as Map<String, dynamic>;
            final userDoc = snapshot.data!.docs.first;
            status = userDoc.get('Status');
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 450,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  'lib/assets/bday template 1.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 89,
                                  left: 60,
                                  child: CircleAvatar(
                                    backgroundImage:
                                    AssetImage('lib/assets/birthday party.jpg'),
                                    radius: 118,
                                  ),
                                ),
                                Align(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 300),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          bdayList['Title'],
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'CurlyThin',
                                          ),
                                        ),
                                        Text(bdayList['DateTime']),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(bdayList['Location']),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              color: Colors.blue.shade100,
                            ),
                            width: 350,
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                bdayList['Eventhighlights'],
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
           isButton = false;
            return Center(child: Text('No Designs are available'));
          }
        },
      ),
    );
  }
}
