import 'package:flutter/material.dart';

class EditWeddingCardTemplate extends StatefulWidget {
  EditWeddingCardTemplate({super.key});

  @override
  State<EditWeddingCardTemplate> createState() => _EditWeddingCardTemplateState();
}

class _EditWeddingCardTemplateState extends State<EditWeddingCardTemplate> {
  bool AddInfo=false;
  bool isEditingGroom = false;
  bool isEditingBride = false;
  bool isEditingDay = false;
  bool isEditingDate = false;
  bool isEditingTime = false;
  bool isEditingMonth = false;
  bool isEditingPlace = false;
  


  TextEditingController Groom_controller = TextEditingController(text: 'Alexander');
  TextEditingController Bride_controller = TextEditingController(text: 'Adeline');
  TextEditingController Day_controller = TextEditingController(text: 'SATURDAY');
  TextEditingController Date_controller = TextEditingController(text: '26');
  TextEditingController Time_controller = TextEditingController(text: '10:00 AM');
  TextEditingController Month_controller = TextEditingController(text: 'NOVEMBER');
  TextEditingController Place_controller = TextEditingController(text: '123 Anywhere St.Ernakulam');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit",style: TextStyle(color: Color(0xFF3d466b),fontFamily: 'Cinzel'),),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.blue,
              ))),
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
                      Navigator.pushNamed(context, 'Wedding Template');
                    },
                    child: Text(
                      "Done",
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
                              GestureDetector(
                                onTap: (){
                                     setState(() {
                                       isEditingBride=true;
                                     });
                                },
                                child: isEditingBride?Container(
                                  height: 30,
                                  width: 150,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontFamily: 'CurlyThin', fontSize: 24),
                                    controller: Bride_controller,
                                  ),
                                )
                                :Text(
                                  "Adeline",
                                  style: TextStyle(
                                      fontFamily: 'CurlyThin', fontSize: 24),
                                ),
                              ),
                              Text("&",
                                  style: TextStyle(
                                      fontFamily: 'CurlyThin', fontSize: 24)),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isEditingGroom=true;
                                  });
                                },
                                child: isEditingGroom?Container(
                                  height: 40,
                                  width: 150,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontFamily: 'CurlyThin', fontSize: 24),
                                    controller: Groom_controller,
                                  ),
                                )
                                    :Text(
                                  "Alexander",
                                  style: TextStyle(
                                      fontFamily: 'CurlyThin', fontSize: 24),
                                ),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 82),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isEditingDay=true;
                                        });
                                      },
                                      child: isEditingDay?Container(
                                        height: 50,
                                        width: 50,
                                        child: TextFormField(
                                          controller: Day_controller,

                                        ),
                                      )
                                      :Text(
                                        "SATURDAY ",
                                        style: TextStyle(fontSize: 12),
                                      ),
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
                AddInfo?Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(onPressed: (){
                              setState(() {
                                AddInfo=false;
                              });
                            }, icon: Icon(Icons.delete)))
                      ],
                    ),
                  ),
                ):Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        AddInfo=true;
                      });
                    }, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.add),Text(" Add info "),],)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
