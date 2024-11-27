import 'package:flutter/material.dart';

class Registernewevent extends StatelessWidget {
  const Registernewevent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('lib/assets/bday party.jpg'),fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade200,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Birthday Party of Arun",style: TextStyle(color: Colors.white),),
                    Text("Date : 08/11/24",style: TextStyle(color: Colors.white),),
                    Text("Place : Ernakulam",style: TextStyle(color: Colors.white),),
                    Text("Cake cutting at 6 PM",style: TextStyle(color: Colors.white),),

                  ],
                )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
