import 'package:flutter/material.dart';

class Businessseminar extends StatelessWidget {
  const Businessseminar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 168,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pushNamed(context, 'EditBusinessSeminar');
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 16),
                    ))),
            SizedBox(
              width: 4,
            ),
            Container(
                width: 168,
                //width:MediaQuery.of(context).size.width/2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pushNamed(context, 'Seminar Template');
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )))
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 500,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage('lib/assets/Seminar Template new.jpg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "INGOUDE COMPANY",
                          style: TextStyle(color: Colors.white,fontFamily: 'TimesNewRoman'),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "BUSINESS SEMINAR",
                          style: TextStyle(
                              fontSize: 34, fontFamily: 'TimesNewRoman'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text("TOPIC : ",style: TextStyle(fontSize: 16,fontFamily: 'TimesNewRoman'),),
                          Text(
                            "REFINING YOUR TEAM LEADERSHIP",
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'TimesNewRoman'),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 40),
                                child: Container(
                                  height: 60,
                                  width: 165,
                                  //color: Colors.blue,
                                  child: Text(
                                    "Join us for strategic leadership and long-term success",
                                    style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'TimesNewRoman'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 17),
                                child: Container(
                                  height: 100,
                                  width: 165,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Topic Highlights : ",
                                        style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'TimesNewRoman'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Understanding role of a leader",
                                          style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'TimesNewRoman'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Analyzing case studies",
                                          style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'TimesNewRoman'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 15),
                                child: Container(
                                  height: 100,
                                  width: 165,
                                  //color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "17 March 2025",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20,fontFamily: 'TimesNewRoman'),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "10:00 AM",
                                              style: TextStyle(color: Colors.white,fontFamily: 'TimesNewRoman'),
                                            ),
                                            Text("-",
                                                style:
                                                    TextStyle(color: Colors.white,fontFamily: 'TimesNewRoman')),
                                            Text("1:00 PM",
                                                style:
                                                    TextStyle(color: Colors.white,fontFamily: 'TimesNewRoman'))
                                          ],
                                        ),
                                        Text("Ernakulam",style: TextStyle(color: Colors.white,fontFamily: 'TimesNewRoman'),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6, bottom: 10, top: 49),
                                child: Container(
                                  height: 22,
                                  width: 144,
                                 // color: Colors.yellow,
                                  child: Center(child: Text("SPEAKERS :",style: TextStyle(fontFamily: 'TimesNewRoman'),)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: Container(
                                  height: 120,
                                  width: 150,

                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                    image: DecorationImage(

                                        image: AssetImage('lib/assets/Corporate_Event.jpg'),fit: BoxFit.cover)
                                  ),
                                ),
                              ),
                              //SizedBox(height: 7,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 120,
                                  width: 150,

                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                      image: DecorationImage(
                                          image: AssetImage('lib/assets/Corporate_Event.jpg'),fit: BoxFit.cover)
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                             // color: Colors.white,
                              height: 20,
                             // width: 70,
                              child: Row(
                                children: [
                                  Icon(Icons.phone,color: Colors.white,size: 16,),
                                  SizedBox(width: 5,),
                                  Text("8907146244",style: TextStyle(color: Colors.white,fontSize: 11,fontFamily: 'TimesNewRoman'),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              // color: Colors.white,
                              height: 20,
                             // width: 100,
                              child: Row(
                                children: [
                                  Icon(Icons.language,color: Colors.white,size: 16,),
                                  SizedBox(width: 5,),
                                  Text("www.ingoude.com",style: TextStyle(color: Colors.white,fontSize: 11,fontFamily: 'TimesNewRoman'),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
