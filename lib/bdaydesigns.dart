import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BdayDesign extends StatelessWidget {
  BdayDesign({super.key});

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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                width: 175,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pushNamed(context, 'Edit Bday Template');
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 16),
                    ))),
          ),
          Container(
              width: 175,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    Navigator.pushNamed(context, 'Home Screen');
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )))
        ],
      ),
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
                          height: 200,
                          width: 350,
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cake cutting at 4:30 PM",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Party Games at 5:00 PM",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Special Events : ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text("  1.Magic Show  at 5:30 PM"),
                                Text("  2.Photo Booth at 5:45 PM ")
                              ],
                            ),
                          ),
                        )
                      ],
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
