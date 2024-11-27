import 'package:flutter/material.dart';

class WeddingCardTemplate extends StatelessWidget {
  WeddingCardTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'Home Screen');
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
                      Navigator.pushNamed(context, 'Edit Wedding Template');
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
                    onPressed: () {},
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
                  height: 450,
                  width: 350,
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage(
                              'lib/assets/Wedding Card Template 2.jpg'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Wedding Ceremony",
                                style: TextStyle(
                                    fontFamily: 'CurlyThin',
                                    fontSize: 21,
                                    fontWeight: FontWeight.w200),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("We invite your pleasure to come  ",
                                  style: TextStyle(fontFamily: 'TimesNewRoman')),
                              Text("to the wedding ceremony of ",
                                  style: TextStyle(fontFamily: 'TimesNewRoman')),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Adeline",
                                style: TextStyle(
                                    fontFamily: 'CurlyThin', fontSize: 24),
                              ),
                              Text("&",
                                  style: TextStyle(
                                      fontFamily: 'CurlyThin', fontSize: 24)),
                              Text(
                                "Alexander",
                                style: TextStyle(
                                    fontFamily: 'CurlyThin', fontSize: 24),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 82),
                                    child: Text(
                                      "SATURDAY ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(
                                      "26 ",
                                      style: TextStyle(
                                          fontFamily: 'CurlyThin', fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text("AT 10:00 AM",
                                        style: TextStyle(fontSize: 12)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "NOVEMBER",
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'TimesNewRoman'),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "123 Anywhere St., Ernakulam ",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'TimesNewRoman'),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 350,
                 // height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'lib/assets/White and Blue Floral Wedding Reception Card edited.jpg'),
                          fit: BoxFit.cover),
                      color: Color(0xFF6b7c98),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Event Highlights :",
                          style: TextStyle(fontFamily: 'TimesNewRoman'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("Ceremony begins at 4:00 PM,",
                              style: TextStyle(fontFamily: 'TimesNewRoman')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("followed by a reception at 6:00 PM",
                              style: TextStyle(fontFamily: 'TimesNewRoman')),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:5),
                          child: Text("The ceremony will be held in the garden,",
                              style: TextStyle(fontFamily: 'TimesNewRoman')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:5),
                          child: Text(" and the reception in the main hall",
                              style: TextStyle(fontFamily: 'TimesNewRoman')),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
