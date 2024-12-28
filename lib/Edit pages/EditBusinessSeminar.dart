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
  TextEditingController website_controller = TextEditingController();
  TextEditingController speaker_controller = TextEditingController();

  String? docid;

  final CollectionReference Seminar = FirebaseFirestore.instance.collection('Seminar');
  String? mail = FirebaseAuth.instance.currentUser!.email;

  void add_details(context,docid)async{
   // print("*****************************************add details started");
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
      "User Mail":mail,
      "Website":website_controller.text,
      "Speakers":speaker_controller.text,
      "Status":'pending'
    };
    var querySnapshot = await Seminar.get();
    int documentCount = querySnapshot.docs.length;

    // Loop through each document in the collection
    for (int i = 0; i < documentCount; i++) {
      var doc = querySnapshot.docs[i];

      // Check if the 'Email' field in the document matches the current user's email
      if (doc['Email'] == mail) {
        // If a document with the same email is found, update the document
        docid = doc.id; // Get the document ID for updating
        await Seminar.doc(docid).update(data); // Update the document
        print('Document with the same email found. Updated document: $docid');
        return; // Exit the function after updating the document
      }
    }
    await Seminar.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0ecff), //body color
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            Container(
                width: 168,
                //width:MediaQuery.of(context).size.width/2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      add_details(context,docid);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Saved Successfully",style: TextStyle(color: Colors.black),),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 4),
                      ));
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )))
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
          child: ListView(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
          SizedBox(
            height: 10,
          ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
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
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller:Time_controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: "Time"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: speaker_controller,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Speakers ",
                  ),
                  maxLines: null,
                  expands: true,
                  //  textAlign: TextAlign.center,
                ),
              ),SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller:website_controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: "Website"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
