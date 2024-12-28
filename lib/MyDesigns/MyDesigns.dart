import 'package:eventmanagementapp/MyDesigns/My%20DesignsBday.dart';
import 'package:eventmanagementapp/MyDesigns/MyDesignShopInauguration.dart';
import 'package:eventmanagementapp/MyDesigns/MyDesignsSeminar.dart';
import 'package:eventmanagementapp/MyDesigns/bdayDesignTest.dart';
import 'package:flutter/material.dart';
import '../bdaydesigns.dart';
import 'MyDesignGraduation.dart';
import 'MyDesignsWedding.dart';

class MyDesigns extends StatelessWidget {
  const MyDesigns({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, 'Home Screen');
        }, icon: Icon(Icons.arrow_back_ios)),
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
       // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          //scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>BdayDesignTest())),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ecff),
                   // image: DecorationImage(image: AssetImage('lib/assets/bday party.jpg'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("Birthday Card",style: TextStyle(fontSize: 22,color: Color(0xFF3d466b),fontFamily: 'TimesNewRoman'),)),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => Mydesignswedding())),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ecff),
                     // image: DecorationImage(image: AssetImage('lib/assets/wedding_ceremony.jpg'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("Wedding Ceremony",style: TextStyle(fontSize: 22,color: Color(0xFF3d466b),fontFamily: 'TimesNewRoman'))),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>MyDesignsSeminar())),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ecff),
                      //image: DecorationImage(image: AssetImage('lib/assets/Corporate_Event.jpg'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("Business Seminar",style: TextStyle(fontSize: 22,color: Color(0xFF3d466b),fontFamily: 'TimesNewRoman'))),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>MyDesignGraduation())),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ecff),
                      //image: DecorationImage(image: AssetImage('lib/assets/graduation event.jpg'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("Graduation Party",style: TextStyle(fontSize: 22,color: Color(0xFF3d466b),fontFamily: 'TimesNewRoman'))),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>MyDesignShopInauguration())),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ecff),
                      //image: DecorationImage(image: AssetImage('lib/assets/Shop inaugartion.jpg'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("Shop Inaugration",style: TextStyle(fontSize: 22,color: Color(0xFF3d466b),fontFamily: 'TimesNewRoman'))),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
