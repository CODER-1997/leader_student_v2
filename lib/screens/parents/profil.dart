 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/theme.dart';
 import '../../../controllers/students/student_controller.dart';
import '../admin/students/grades.dart';

class ParentsProfil extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  StudentController studentController = Get.put(StudentController());

  GetStorage box = GetStorage();




  String calculateAverage(List list) {
   dynamic val = 0;
   if(list.isNotEmpty){

     for(var item in list){
       val += int.parse(item['grade']);
     }
     val   = val/list.length;
     return  "O'rtacha: '${val.toString().substring(0,2)} %'";

   }




    return  'Baholanmagan';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        backgroundColor: dashBoardColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: true,
        title: Text(
          "Student profil",
          style: appBarStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: getDocumentStreamById('LeaderStudents', box.read('student_doc_id')),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('Document not found');
            } else {
              // Access the document data
              Map<String, dynamic> data =  snapshot.data!.data() as Map<String, dynamic>;
              studentController
                  .isFreeOfCharge
                  .value =
                  data['items']['isFreeOfcharge'] ?? false;
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)

                    ),
                    child: ListTile(

                      contentPadding: EdgeInsets.all(8),
                      leading: Image.asset(
                        'assets/student_avatar.png',
                        width: 64,
                      ),
                      subtitle: Text("Id: ${data['items']['uniqueId']}"),
                      title: Text(
                        "${data['items']['name']}".capitalizeFirst! +
                            "   " +
                            "${data['items']['surname']}".capitalizeFirst!,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                  
                    ),
                    child: ListTile(
                    trailing: InkWell(
                      onTap: (){
                        Get.to(Grades(grades: data['items']['grades'] ?? []));
                      },
                      child: Text("Ko'proq",style: appBarStyle.copyWith(
                        fontSize: 12,
                        color: Colors.blue
                      ),),
                    ),
                      contentPadding: EdgeInsets.all(8),
                      leading: Image.asset(
                        'assets/learning_process.png',
                        width: 64,
                      ),
                      subtitle: Text("${calculateAverage(data['items']['grades']??[])}"),
                      title: Text(
                        "O'zlashtirishi".capitalizeFirst!,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),


                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Stream<DocumentSnapshot> getDocumentStreamById(
    String collection, String documentId) {
  DocumentReference documentRef =
  FirebaseFirestore.instance.collection(collection).doc(documentId);
  return documentRef.snapshots();
}
