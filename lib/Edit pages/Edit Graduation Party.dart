import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditGraduation extends StatefulWidget {
  EditGraduation({super.key});

  @override
  State<EditGraduation> createState() => _EditGraduationState();
}

class _EditGraduationState extends State<EditGraduation> {
   final CollectionReference Graduation=FirebaseFirestore.instance.collection('Graduation');

    String? docid;
   String? mail = FirebaseAuth.instance.currentUser!.email;

 TextEditingController name_controller = TextEditingController();

 TextEditingController date_controller = TextEditingController();

 TextEditingController time_controller = TextEditingController();

 TextEditingController location_controller = TextEditingController();

 void add_details(context,docid)async{
   final data= {
         "Name":name_controller.text,
         "Date":date_controller.text,
         "Time":time_controller.text,
         "Location":location_controller.text,
         "Mail":mail,
         "Title":'Graduation of $name_controller',
          "Status":'pending'
       };
   var QuerySnapshot = await Graduation.get();
   if(QuerySnapshot.docs.isNotEmpty)
   {
     docid = QuerySnapshot.docs[0].id;
   }
   await Graduation.doc(docid).update(data);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0ecff),//background color
      appBar: AppBar(
        backgroundColor: Color(0xFFf0ecff),//appbar color
        title: Text("Edit",style: TextStyle(fontFamily: 'TimesNewRoman'),),
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, 'Graduation Template');
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: (){
              add_details(context,docid);
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
                  labelText: "Enter the name"),
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
              controller: time_controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: "Enter the time"),
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
