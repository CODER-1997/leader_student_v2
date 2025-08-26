import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/theme.dart';
import '../../../constants/utils.dart';
import '../../../controllers/students/student_controller.dart';
import '../../constants/custom_widgets/choose_field_card.dart';
import '../../controllers/auth/login_controller.dart';
import '../admin/statistics/calendar_view.dart';
import '../admin/students/exams.dart';
import '../admin/students/student_payment_history.dart';

class ParentMain extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  StudentController studentController = Get.put(StudentController());

  GetStorage box = GetStorage();

  FireAuth auth = Get.put(FireAuth());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.logOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        backgroundColor: dashBoardColor,
        automaticallyImplyLeading: true,
        title: Text(
          "Student profil",
          style: appBarStyle.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: getDocumentStreamById(
              'LeaderStudents', box.read('student_doc_id')),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('Document not found');
            } else {
              // Access the document data
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              studentController.isFreeOfCharge.value =
                  data['items']['isFreeOfcharge'] ?? false;
              return Column(
                children: [
                  calculateUnpaidMonths(data['items']['studyDays'],
                      data['items']['payments'])
                      .length !=
                      0
                      ?   ListTile(
                    tileColor: Colors.red,
                    leading: Icon(Icons.warning_outlined),
                    iconColor: Colors.white,
                    title: Text(
                      "Sizda qarzdorlik mavjud",
                      style: TextStyle(color: Colors.white),
                    ),
                  ):SizedBox(),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AdminStudentPaymentHistory(
                        uniqueId: data['items']['uniqueId'],
                        id: box.read('student_doc_id'),
                        name: data['items']['name'],
                        totalFee: '',
                        surname: data['items']['surname'],
                        showButton: false,
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: ChooseField(
                          title: "Kurs to'lovi tarixi shu yerda",
                          img: 'gold_bill',
                          color1: Color(0xffff0000),
                          color2: Color(0xffef78cd),
                          top_title: "Kurs to'lovi"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
        var list = [];


        for (int i = 0;  i < data['items']['studyDays'].length;  i++) {
          if (data['items']['studyDays'][i].toString().endsWith('1')||data['items']['studyDays'][i].toString().endsWith('0') ) {
            var item = data['items']['studyDays'][i].toString().split('_');
            list.add({
              'isAttended': data['items']['studyDays'][i].toString().endsWith('1')  ? true:false,


              'day': DateFormat('dd-MM-yyyy')
                  .parse(item[1])
            });
          }
        }






        Get.to(CalendarScreen(
          days: list,
        ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: ChooseField(
                          title:
                              'Farzandingizni davomatini onlayn kuzatib boring',
                          img: 'calendar',
                          color1: Color(0xff5E5BC5),
                          color2: Color(0xff78E2EF),
                          top_title: "Davomat"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AdminStudentExam(
                        showButton: false,
                        uniqueId: '${data['items']['uniqueId']}',
                        id: box.read('student_doc_id'),
                        name: data['items']['name'],
                        surname: data['items']['surname'],
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: ChooseField(
                          title: 'Imtihon natijalari shu yerda',
                          img: 'exam',
                          color1: Color(0xff076e30),
                          color2: Color(0xff66f89c),
                          top_title: "Imtihonlar"),
                    ),
                  )
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
