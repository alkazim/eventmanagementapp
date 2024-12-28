import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditShopInauguration extends StatelessWidget {
   EditShopInauguration({super.key});

  TextEditingController name_controller = TextEditingController();
   TextEditingController day_controller = TextEditingController();
   TextEditingController date_controller = TextEditingController();
   TextEditingController location_controller = TextEditingController();

   final CollectionReference Inauguration =
   FirebaseFirestore.instance.collection('Inauguration');
   String? mail = FirebaseAuth.instance.currentUser!.email;
   String? docid;
   void add_details(context,docid) async {
     final data = {
       "ShopName": name_controller.text,
       "Day": day_controller.text,
       "Date": date_controller.text,
       "Email": mail,
       "Location":location_controller.text,
       "Status":'pending'
     };
     var QuerySnapshot = await Inauguration.get();
     if(QuerySnapshot.docs.isNotEmpty)
     {
       docid = QuerySnapshot.docs[0].id;
     }
     await Inauguration.doc(docid).update(data); var querySnapshot = await Inauguration.get();
     int documentCount = querySnapshot.docs.length;

     // Loop through each document in the collection
     for (int i = 0; i < documentCount; i++) {
       var doc = querySnapshot.docs[i];

       // Check if the 'Email' field in the document matches the current user's email
       if (doc['Email'] == mail) {
         // If a document with the same email is found, update the document
         docid = doc.id; // Get the document ID for updating
         await Inauguration.doc(docid).update(data); // Update the document
         print('Document with the same email found. Updated document: $docid');
         return; // Exit the function after updating the document
       }
     }
     await Inauguration.add(data);
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFf0ecff),//appbar color
          title: Text("Edit",style: TextStyle(fontFamily: 'TimesNewRoman'),),
          leading: IconButton(onPressed: (){
            Navigator.pushNamed(context, 'Shop Inauguration Template');
          }, icon: Icon(Icons.arrow_back_ios)),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: (){
                   add_details(context, docid);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.white,
                      duration:  Duration(seconds: 4),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Saved Successfully",style: TextStyle(color: Colors.black),)));
                  Navigator.pushNamed(context, 'Home Screen');
                }, child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18),),)
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: name_controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: "Enter the Shop name"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: date_controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: "Enter the date"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: day_controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: "Enter the day"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: location_controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: "Enter the location"),
            ),
          ],
        ),
      ),
    );
  }
}
