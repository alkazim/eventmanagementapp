import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditBusinessSeminar extends StatelessWidget {
  EditBusinessSeminar({super.key});

  TextEditingController CompanyName_controller = TextEditingController();
  TextEditingController Title_controller = TextEditingController();
  TextEditingController Topic_controller = TextEditingController();
  TextEditingController Text1_controller = TextEditingController();
  TextEditingController TopicHighlights_controller = TextEditingController();
  TextEditingController Time_controller = TextEditingController();
  TextEditingController Mobile_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController Date_controller = TextEditingController();
  TextEditingController Location_controller = TextEditingController();

  final CollectionReference Seminar = FirebaseFirestore.instance.collection('Seminar');
  String? mail = FirebaseAuth
      .instance.currentUser!.email;

  void add_details(context)async{
    final data ={
      "Company Name":CompanyName_controller.text,
      "Title":Title_controller.text,
      "Topic":Topic_controller.text,
      "Text1":Text1_controller.text,
      "Topic Highlights":TopicHighlights_controller.text,
      "Time":Time_controller.text,
      "Mobile":Mobile_controller.text,
      "Seminar Email":email_controller.text,
      "Date":Date_controller.text,
      "Location":Location_controller.text,
      "User Mail":mail

    }; await Seminar.add(data);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0ecff), //body color
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
                      Navigator.pushNamed(context, 'Seminar Template');
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
      appBar: AppBar(
        backgroundColor: Color(0xFFf0ecff), //body color,
        title: Text("Edit"),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'Seminar Template');
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller:CompanyName_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Company Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Title_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Title"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller:Topic_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Topic"),
              ),
              TextFormField(
                controller:Text1_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Text"),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: TopicHighlights_controller,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: "Topic Highlights ",

                    ),
                    maxLines: null,
                    expands: true,
                    //  textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextFormField(
                controller:Time_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Time"),
              ),TextFormField(
                controller:Mobile_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Mobile"),
              ),
              TextFormField(
                controller:email_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "E mail"),
              ),
              TextFormField(
                controller:Date_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Date"),
              ),
              TextFormField(
                controller:Location_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
