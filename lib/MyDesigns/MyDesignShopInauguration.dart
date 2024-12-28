import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:typed_data'; // For using Uint8List
import 'dart:ui' as ui; // For image manipulation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart'; // gal package for saving images
import 'package:permission_handler/permission_handler.dart'; // For handling permissions

class MyDesignShopInauguration extends StatelessWidget {
   MyDesignShopInauguration({super.key});

  final CollectionReference Inauguration =
  FirebaseFirestore.instance.collection('Inauguration');
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
     automaticallyImplyLeading: false,
     leading: IconButton(onPressed: (){Navigator.pushNamed(context, 'My Designs');}, icon: Icon(Icons.arrow_back_ios)),
     title: Text("Shop Inauguration",style: TextStyle(fontFamily: 'TimesNewRoman'),),
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
      body: StreamBuilder(
          stream: Inauguration.where('Email',isEqualTo:mail ).snapshots(),
          builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error occurred: ${snapshot.error}'));
    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
      final Shoplist = documentSnapshot.data() as Map<String, dynamic>;
      return Container(
          child: RepaintBoundary(
            key: _globalKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 450,
                        width: 350,
                        decoration: BoxDecoration(image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/Images/Event Templates/Grand Opening Invitation Template.jpg'),
                            fit: BoxFit.cover)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("YOU ARE INVITED TO THE", style: TextStyle(
                                      fontFamily: 'TimesNewRoman'),),
                                  SizedBox(height: 10,),
                                  Text("Grand Opening", style: TextStyle(
                                      fontFamily: 'CurlyThin', fontSize: 30),),
                                  SizedBox(height: 10,),
                                  Text("OF OUR NEW", style: TextStyle(
                                      fontFamily: 'TimesNewRoman'),),
                                  SizedBox(height: 10,),
                                  Text(Shoplist['ShopName'], style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'TimesNewRoman'),),
                                  SizedBox(height: 10,),
                                  Text("ON ${Shoplist['Date']}", style: TextStyle(
                                      fontFamily: 'TimesNewRoman'),),
                                  SizedBox(height: 15,),
                                  Text("LOCATION : ${Shoplist['Location']}", style: TextStyle(
                                      fontFamily: 'TimesNewRoman'),),
                                  SizedBox(height: 15,),
                                  Text("Dont Miss it !!!", style: TextStyle(
                                      fontFamily: 'CurlyThin', fontSize: 20),)
                                ],
                              )
                            ],
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
    }
    else
      {
        return Center(child: Text("No Designs are available"));

      }
    }
    ,),
    );
  }
}
