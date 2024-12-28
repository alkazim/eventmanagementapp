import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String? snacktext;
  Future<void> savedUser(userId)async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('UserId', userId);
  }

  Future <void> login_user(context)async{
  try{
   await FirebaseAuth.instance.signInWithEmailAndPassword(email: _username.text.trim(), password: _password.text.trim());
   savedUser(FirebaseAuth.instance.currentUser?.uid);
   Navigator.pushNamed(context, 'Home Screen');
  }on FirebaseAuthException catch(e)
    {
      if(e=='[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.')
        {
          snacktext='Invalid Credentials';
        }
     // else if()
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          content: Text(snacktext!)));
      print("Error in login -----------$e");
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
                    child: Text("Login",
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
                  Align(
                    alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){},
                          child: Text("Forgot Password?",style: TextStyle(color:Colors.blue,decoration: TextDecoration.underline),),

                           )),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 220,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        login_user(context);
                      },
                      child: Text(
                        "Login",
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
                      Text("Dont have an account ?"),
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, 'Signup Page');
                      }, child: Text("Sign up",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),))
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
