import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void>signup_user(context) async{
  final password = _password.text.trim();
  final confirmpass = _confirmpass.text.trim();


  if(password==confirmpass)
    {
       try{
             final UserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _username.text, password: _password.text);
             Navigator.pushNamed(context, 'Login Page');
             final String uid = UserCredential.user!.uid;

              await FirebaseFirestore.instance.collection('users').doc(_username.text).set({
                'Email':_username.text,
                'Role':'user',
                'Uid':uid,
              }).then((_) {
                // Navigate to login page on successful signup
                Navigator.pushNamed(context, 'Login Page');
              }).catchError((e) {
                // Handle Firestore errors
                print("Error updating Firestore: $e");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Error updating Firestore")));
              });
       }on FirebaseAuthException catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         // behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          content: Text("Error in signup")));
      print("Error in Signup --------- $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in signup")));

    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          // alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            height: 400,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                        labelText: 'Email ID',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        )),
                    obscureText: true,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _confirmpass,
                    decoration: InputDecoration(
                        labelText: 'confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        )),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 220,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        signup_user(context);
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?"),
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, 'Login Page');
                      }, child: Text("Log in",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
