import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Editbdaytemplate extends StatefulWidget {
  Editbdaytemplate({super.key});

  @override
  State<Editbdaytemplate> createState() => _EditbdaytemplateState();
}
final CollectionReference Birthday =
FirebaseFirestore.instance.collection('Birthday');
class _EditbdaytemplateState extends State<Editbdaytemplate> {


  TextEditingController Title_controller = TextEditingController();

  TextEditingController DateTime_controller = TextEditingController();

  TextEditingController Location_controller = TextEditingController();

  TextEditingController EventHighlights_controller = TextEditingController();

  final ImagePicker imagePick = ImagePicker();

  String? imageUrl;

  XFile? imageFile;

  String? docid;


  String? mail = FirebaseAuth
      .instance.currentUser!.email;

  // void add_details(context,docid) async {
  //   final data = {
  //     "DateTime": DateTime_controller.text,
  //     "Title": Title_controller.text,
  //     "Location": Location_controller.text,
  //     "Eventhighlights": EventHighlights_controller.text,
  //     "Email": mail,
  //     "ImageUrl":imageUrl,
  //     "Status":'pending'
  //   };
  //   var QuerySnapshot = await Birthday.get();
  //   if(QuerySnapshot.docs.isNotEmpty)
  //     {
  //       docid = QuerySnapshot.docs[0].id;
  //     }
  //   await Birthday.doc(docid).update(data);
  //  // await Birthday.add(data);
  // }
  void add_details(context, docid) async {
    final data = {
      "DateTime": DateTime_controller.text,
      "Title": Title_controller.text,
      "Location": Location_controller.text,
      "Eventhighlights": EventHighlights_controller.text,
      "Email": mail,
      "ImageUrl": imageUrl,
      "Status": 'pending'
    };

    // Fetch all documents from the 'Birthday' collection
    var querySnapshot = await Birthday.get();
    int documentCount = querySnapshot.docs.length;

    // Loop through each document in the collection
    for (int i = 0; i < documentCount; i++) {
      var doc = querySnapshot.docs[i];

      // Check if the 'Email' field in the document matches the current user's email
      if (doc['Email'] == mail) {
        // If a document with the same email is found, update the document
        docid = doc.id;  // Get the document ID for updating
        await Birthday.doc(docid).update(data);  // Update the document
        print('Document with the same email found. Updated document: $docid');
        return;  // Exit the function after updating the document
      }
    }

    // If no document with the same email is found, create a new document with the email
    await Birthday.add(data);
    print('No document found with the same email. New document added.');
  }


  Future<void> getImage() async {
    final XFile? pickedImage =
    await imagePick.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
      // Upload image and get URL
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (imageFile != null) {
      File file = File(imageFile!.path);
      try {
        Reference ref =
        FirebaseStorage.instance.ref('images/${imageFile!.name}');
        print("==================================================================Picked image path: ${imageFile!.path}");

        await ref.putFile(file); // Upload file
        String downloadUrl = await ref.getDownloadURL();
        print("==============================================================================Download Url : $downloadUrl");
        setState(() {
          imageUrl = downloadUrl;
        });
        print("========================================================================================Image URL: $imageUrl");
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
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
                      Navigator.pushNamed(context, 'Bday Template');
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
                      uploadImageToFirebase();
                      add_details(context,docid);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.white,
                          duration:  Duration(seconds: 4),
                          behavior: SnackBarBehavior.floating,
                          content: Text("Saved Successfully",style: TextStyle(color: Colors.black),)));
                      Navigator.pushNamed(context, 'Home Screen');
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
              Navigator.pushNamed(context, 'Bday Template');
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // CircleAvatar(
              //   radius: 60,
              //   backgroundColor: Colors.grey.shade200,
              //   backgroundImage: imageFile != null
              //       ? FileImage(File(imageFile!.path))
              //       : null,
              //   child: imageFile == null
              //       ? Text("No Image", style: TextStyle(fontSize: 16, color: Colors.grey))
              //       : null,
              // ),

              // SizedBox(height: 5,),
              // ElevatedButton(onPressed: (){getImage();}, child: Text("Upload Image")),
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
                    labelText: "Enter the title"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: DateTime_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Date and Time"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Location_controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: "Location"),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: EventHighlights_controller,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: "Event Highlights ",
                    ),
                    maxLines: null,
                    expands: true,
                    //  textAlign: TextAlign.center,
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
