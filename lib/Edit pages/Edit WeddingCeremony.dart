import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditWeddingCeremony extends StatelessWidget {
  EditWeddingCeremony({super.key});

  final CollectionReference Wedding = FirebaseFirestore.instance.collection('Wedding');

  TextEditingController Bride_controller = TextEditingController();
  TextEditingController Groom_controller = TextEditingController();
  TextEditingController Day_controller = TextEditingController();
  TextEditingController Date_controller = TextEditingController();
  TextEditingController Time_controller = TextEditingController();
  TextEditingController Month_controller = TextEditingController();
  TextEditingController Place_controller = TextEditingController();
  TextEditingController EventHighlights_controller = TextEditingController();
  String? mail = FirebaseAuth
      .instance.currentUser!.email;

  String? docid;



  void add_details(context,docid) async{
    final data ={
      "Bride":Bride_controller.text,
      "Date":Date_controller.text,
      "Day":Day_controller.text,
      "Groom":Groom_controller.text,
      "Month":Month_controller.text,
      "Place":Place_controller.text,
        "Time":Time_controller.text,
      "Mail":mail,
      "Event Highlights":EventHighlights_controller.text,
      "Title":'Wedding of $Bride_controller and $Groom_controller',
      "Status":'pending'
    };
    var querySnapshot = await Wedding.get();
    int documentCount = querySnapshot.docs.length;

    // Loop through each document in the collection
    for (int i = 0; i < documentCount; i++) {
      var doc = querySnapshot.docs[i];

      // Check if the 'Email' field in the document matches the current user's email
      if (doc['Email'] == mail) {
        // If a document with the same email is found, update the document
        docid = doc.id;  // Get the document ID for updating
        await Wedding.doc(docid).update(data);  // Update the document
        print('Document with the same email found. Updated document: $docid');
        return;  // Exit the function after updating the document
      }
    }
    await Wedding.add(data);
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
                    onPressed: () {
                      add_details(context,docid);
                      Navigator.pushNamed(context, 'Home Screen');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          content: Text("Created Successfully !!")));
                    },
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
              Navigator.pushNamed(context, 'Wedding Template');
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: Bride_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Bride's Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Groom_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Groom's Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Day_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Day"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Date_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Date"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Time_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Time"),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: Month_controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: "Month"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: Place_controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: "Place"),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Additional information : "),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: EventHighlights_controller,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: "Event Highlights "),
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
