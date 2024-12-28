import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:screenshot/screenshot.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

class MyDesignsBday extends StatelessWidget {
  MyDesignsBday({super.key});

  //final ScreenshotController screenshotController = ScreenshotController();
  String? mail = FirebaseAuth.instance.currentUser!.email;

  final CollectionReference Birthday =
  FirebaseFirestore.instance.collection('Birthday');


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
      bottomNavigationBar: Container(
        width: 175,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: () {
          },

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Download",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Icon(
                Icons.download,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFf0ecff),
      body: StreamBuilder(
        stream: Birthday.where('Email', isEqualTo: mail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final bdayList = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: bdayList.map<Widget>((documentSnapshot) {
                  final bday = documentSnapshot.data() as Map<String, dynamic>;
                 // return Screenshot(
                  return Container(    // changed screenshot with container
                   // controller: screenshotController,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/assets/bday template 1.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bday['Title'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text("Date: ${bday['DateTime']}"),
                                Text("Location: ${bday['Location']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(child: Text('No birthday templates available.'));
          }
        },
      ),
    );
  }
}
