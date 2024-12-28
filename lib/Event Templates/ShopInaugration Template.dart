import 'package:flutter/material.dart';

class ShopInaugrationTemplate extends StatelessWidget {
  const ShopInaugrationTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                width: 175,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pushNamed(context, 'Edit Inauguration template');
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 16),
                    ))),
          ),
          Container(
              width: 175,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    Navigator.pushNamed(context, 'Home Screen');
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )))
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, 'Home Screen');
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 450,
                    width: 350,
                    decoration: BoxDecoration(image: DecorationImage(
                        image: AssetImage('lib/assets/Images/Event Templates/Grand Opening Invitation Template.jpg'),
                        fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("YOU ARE INVITED TO THE",style: TextStyle(fontFamily: 'TimesNewRoman'),),
                            SizedBox(height: 10,),
                            Text("Grand Opening",style: TextStyle(fontFamily: 'CurlyThin',fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("OF OUR NEW",style: TextStyle(fontFamily: 'TimesNewRoman'),),
                            SizedBox(height: 10,),
                            Text("BEAUTY SALOON & SPA",style: TextStyle(fontSize: 20,fontFamily: 'TimesNewRoman'),),
                            SizedBox(height: 10,),
                            Text("ON 28 JANUARY 2025",style: TextStyle(fontFamily: 'TimesNewRoman'),),
                            SizedBox(height: 15,),
                            Text("LOCATION : Ernakulam",style: TextStyle(fontFamily: 'TimesNewRoman'),),
                            SizedBox(height: 15,),
                            Text("Dont Miss it !!!",style: TextStyle(fontFamily: 'CurlyThin',fontSize: 20),)
                          ],
                        )
                      ],
                    ),
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
