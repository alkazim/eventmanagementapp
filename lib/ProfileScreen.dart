import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.logout_outlined,color: Color(0xFF3d466b),))],
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Text(
              "My Profile",
              style: TextStyle(fontSize: 28,color: Color(0xFF3d466b),fontFamily: 'Cinzel',fontWeight: FontWeight.w800),
            ),
          ),
        ),
        backgroundColor: Color(0xFFf0ecff),// appBar color
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFFf0ecff),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/graduation profile pic.jpg'),
                  radius: 70,
                  // child: Icon(Icons.person),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
