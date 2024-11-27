import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDesignsBday extends StatelessWidget {
  MyDesignsBday({super.key});

  String? mail = FirebaseAuth.instance.currentUser!.email;

  final CollectionReference Birthday =
      FirebaseFirestore.instance.collection('Birthday');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              scrollDirection: Axis.vertical,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: bdayList.map<Widget>((documentSnapshot) {
                      final bday =
                          documentSnapshot.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
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
                                      backgroundImage: AssetImage(
                                          'lib/assets/birthday party.jpg'),
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
                                            bday['Title'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: 'CurlyThin'),
                                          ),
                                          SizedBox(height: 5,),
                                          Text(bday['DateTime']),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(bday['Location']),
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
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        bday['Eventhighlights'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      );
                    }).toList(),
                  ),
                ),
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
