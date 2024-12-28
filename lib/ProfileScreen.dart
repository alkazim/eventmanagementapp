// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventmanagementapp/Approval%20page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});
// *
//   final String? mail = FirebaseAuth.instance.currentUser!.email;
//   bool? isAdmin = false;
//
//   final CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//   // Function to check admin status
//   void checkAdminStatus(String? role) {
//     if (role == 'admin') {
//       isAdmin = true;
//     } else {
//       isAdmin = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.pushNamed(context, 'Login Page');
//             },
//             icon: Icon(Icons.logout_outlined, color: Color(0xFF3d466b)),
//           ),
//         ],
//         title: Center(
//           child: Text(
//             "My Profile",
//             style: TextStyle(
//               fontSize: 28,
//               color: Color(0xFF3d466b),
//               fontFamily: 'Cinzel',
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ),
//         backgroundColor: Color(0xFFf0ecff),
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: Color(0xFFf0ecff),
//       body: FutureBuilder<QuerySnapshot>(
//         future: users.where('Email', isEqualTo: mail).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             print("Error: ${snapshot.error}");
//             return Center(child: Text("Error retrieving user data."));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             print("No data found for user: $mail");
//             return Center(child: Text("No user data available."));
//           }
//
//           final userDoc = snapshot.data!.docs.first;
//           final userRole = userDoc.get('Role');
//           checkAdminStatus(userRole);
//
//           return Center(
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   child: Icon(Icons.person),
//                 ),
//                 Text("$mail"),
//                 //Text("Role: $userRole"),
//                 Container(
//                   child: isAdmin == true
//                       ? ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadApprovalsPage(),));
//                     },
//                     child: Text("Download Approvals"),
//                   )
//                       : SizedBox.shrink(),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagementapp/AboutUs.dart';
import 'package:eventmanagementapp/Approval%20page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final String? mail = FirebaseAuth.instance.currentUser!.email;
  bool? isAdmin = false;

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Function to check admin status
  void checkAdminStatus(String? role) {
    if (role == 'admin') {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, 'Login Page');
            },
            icon: Icon(Icons.logout_outlined, color: Color(0xFF3d466b)),
          ),
        ],
        title: Center(
          child: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 28,
              color: Color(0xFF3d466b),
              fontFamily: 'Cinzel',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        backgroundColor: Color(0xFFf0ecff),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFFf0ecff),
      body: FutureBuilder<QuerySnapshot>(
        future: users.where('Email', isEqualTo: mail).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(child: Text("Error retrieving user data."));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("No data found for user: $mail");
            return Center(child: Text("No user data available."));
          }

          final userDoc = snapshot.data!.docs.first;
          final userRole = userDoc.get('Role');
          checkAdminStatus(userRole);

          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF3d466b),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "$mail",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF3d466b),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  if (isAdmin == true)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DownloadApprovalsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2d9e48),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Download Approvals",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs(),));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF01513a),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "About Us",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

