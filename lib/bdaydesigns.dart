
import 'dart:ui' as ui;
import 'dart:typed_data' as td; // Correct import for ByteData
import 'package:gal/gal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'dart:typed_data'; // For using Uint8List
import 'dart:ui' as ui; // For image manipulation
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart'; // gal package for saving images
import 'package:permission_handler/permission_handler.dart'; // For handling permissions
// Correct BDay Template format
class BdayDesign extends StatelessWidget {
  BdayDesign({super.key});

  final GlobalKey _globalKey = GlobalKey();

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("Permission granted");
    } else {
      print("Permission denied");
      openAppSettings(); // Direct user to settings to enable permission
    }
  }
  Future<void> saveImageToGallery(context) async {
    // Request permission
    await requestStoragePermission();

    try {
      // Capture the widget as a bitmap
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Capture the image

      // Convert the image to bytes
     // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      td.ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      td.Uint8List bytes = byteData!.buffer.asUint8List();


      // Save the image to the gallery
      await Gal.putImageBytes(bytes); // Save the image bytes
      print("Image saved successfully!");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          content: Text("Image saved to your gallery")));
    } catch (e) {
      print('Failed to capture the widget: $e');
    }
  }

  final CollectionReference Birthday =
  FirebaseFirestore.instance.collection('Birthday');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'Home Screen');
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blue,))),
      bottomNavigationBar: Container(
          height: 50,
          width: 50,
          child: Padding(

            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Download",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Icon(Icons.download)
                    ],
                  ),
                )),
          )),
      body: StreamBuilder(
          stream: Birthday.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error occurred: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
              final bdayList = documentSnapshot.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                                    topRight: Radius.circular(12)),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'lib/assets/bday template 1.jpg',
                                    ),
                                    fit: BoxFit.cover)),
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
                                              fontFamily: 'CurlyThin'),
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
                                  bottomRight: Radius.circular(12)),
                              color: Colors.blue.shade100,
                            ),
                            //height: 200,
                            width: 350,
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(bdayList['Eventhighlights'], style: TextStyle(fontSize: 14),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text('No birthday templates available.'));
            }
          }),
    );
  }
}
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'dart:io';
// import 'dart:typed_data';
//
// class BdayDesign extends StatefulWidget {
//   @override
//   _BdayDesign createState() => _BdayDesign();
// }
//
// class _BdayDesign extends State<BdayDesign> {
//   final ScreenshotController screenshotController = ScreenshotController();
//   String? mail = FirebaseAuth.instance.currentUser!.email;
//   final CollectionReference Birthday = FirebaseFirestore.instance.collection('Birthday');
//
//   Future<void> saveCardAsImage(context) async {
//     try {
//       final imageBytes = await screenshotController.capture();
//       if (imageBytes != null) {
//         final result = await ImageGallerySaver.saveImage(
//           Uint8List.fromList(imageBytes),
//           quality: 100,
//           name: "card_design",
//         );
//         if (result["isSuccess"]) {
//           print("Image saved successfully!");
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Image Saved Successfully")),
//           );
//         } else {
//           print("Failed to save image");
//         }
//       } else {
//         print("Failed to capture screenshot");
//       }
//     } catch (e) {
//       print("Error capturing image: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Designs",
//           style: TextStyle(
//             fontSize: 28,
//             color: Color(0xFF3d466b),
//             fontFamily: 'Cinzel',
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         backgroundColor: Color(0xFFf0ecff),
//       ),
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 175,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               onPressed: () {
//                 saveCardAsImage(context);
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Download",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   Icon(
//                     Icons.download,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Color(0xFFf0ecff),
//       body: StreamBuilder(
//         stream: Birthday.where('Email', isEqualTo: mail).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//             final bdayList = snapshot.data!.docs;
//             return SingleChildScrollView(
//               child: Column(
//                 children: bdayList.map<Widget>((documentSnapshot) {
//                   final bday = documentSnapshot.data() as Map<String, dynamic>;
//                   return Screenshot(
//                     controller: screenshotController,
//                     child: Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 250,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage('lib/assets/bday template 1.jpg'),
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(12),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   bday['Title'],
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text("Date: ${bday['DateTime']}"),
//                                 Text("Location: ${bday['Location']}"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           } else {
//             return Center(child: Text('No birthday templates available.'));
//           }
//         },
//       ),
//     );
//   }
// }
