import 'package:flutter/material.dart';

class GraduationTemplate extends StatelessWidget {
  const GraduationTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pushNamed(context, 'Home Screen');
          }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blue,))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 172,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pushNamed(context, 'EditGraduation');
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 16),
                    ))),

            Container(
                width: 172,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )))
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 510,
              width: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'lib/assets/graduation template 1.jpeg',
                      ),
                      fit: BoxFit.cover)),
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 26),
                          child: Container(
                            //width: 100,
                            //height: 20,
                            child: Text("PLEASE JOIN US TO CELEBRATE",style: TextStyle(fontSize: 12,fontFamily: 'TimesNewRoman'),),
                           // color: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 45),
                          child: Container(
                            //height: 70,
                            //width: 150,
                            //color: Colors.teal,
                            child: Column(
                              children: [
                                Text("GRADUATION",style: TextStyle(fontSize: 24,fontFamily: 'TimesNewRoman' ),),
                                Text("PARTY",style: TextStyle(fontSize: 24,fontFamily: 'TimesNewRoman'),)
                              ],
                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage('lib/assets/graduation profile pic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Container(
                            //height: 10,
                            //width: 20,
                           // color: Colors.teal,
                            child: Text("OF",style: TextStyle(fontFamily: 'TimesNewRoman'),),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          //color: Colors.teal,
                          child: Text("DREW FEIG",style: TextStyle(fontFamily: 'TimesNewRoman',fontSize: 24),),
                        ),
                        SizedBox(height: 5,),
                        Container(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("--- "),
                            Text("JULY 18, 2026",style: TextStyle(fontSize: 10,fontFamily: 'TimesNewRoman'),),
                            Text(" ---"),
                          ],
                        ),),
                        SizedBox(height: 5,),
                        Container(
                          child: Text("AT 5:00 PM",style: TextStyle(fontSize: 10,fontFamily: 'TimesNewRoman'),),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          child: Text("123 ANYWHERE ST. ANY CITY",style: TextStyle(fontSize: 10,fontFamily: 'TimesNewRoman'),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
