
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/custom_widgets/FormFieldDecorator.dart';
import '../../../constants/custom_widgets/gradient_button.dart';
import '../../../constants/input_formatter.dart';
import '../../../constants/text_styles.dart';
import '../../../constants/theme.dart';
import '../../../constants/utils.dart';
import '../../../controllers/students/student_controller.dart';

class AdminStudentPaymentHistory extends StatelessWidget {
  StudentController studentController = Get.put(StudentController());

  final String uniqueId;
  final String id;
  final String name;
  final String surname;
  final String totalFee;
  final bool ?  showButton;


  AdminStudentPaymentHistory(
      {required this.uniqueId,
      required this.id,
      required this.name,
      required this.totalFee,
       this.showButton,
      required this.surname});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: dashBoardColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          '${name}'.capitalizeFirst! +
              " " +
              "${surname}".capitalizeFirst! +
              "  to'lovlar tarixi",
          style:
              appBarStyle.copyWith(color: CupertinoColors.white, fontSize: 12),
        ),
        actions: [
     showButton!= false ?     Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        insetPadding: EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        //this right here
                        child: Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            width: Get.width,
                            height: Get.height / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text("To'lov qo'shish"),
                                    IconButton(
                                        onPressed: Get.back,
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      ThousandSeparatorInputFormatter(),
                                    ],
                                    controller: studentController.payment,
                                    decoration: buildInputDecoratione("To'lov miqdori "),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Maydonlar bo'sh bo'lmasligi kerak";
                                      }
                                      return null;
                                    }),



                                Row(
                                  children: [
                                    Obx(
                                      () => Text(
                                          'To\'lov qilingan sana :  ${studentController.paidDate.value}'),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          studentController.showDate(
                                              studentController.paidDate);
                                        },
                                        icon: Icon(Icons.calendar_month))
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate() ) {
                                      studentController.addPayment(
                                          id, studentController.paidDate.value,totalFee);
                                    }
                                  },
                                  child: Obx(() => CustomButton(
                                      isLoading:
                                          studentController.isLoading.value,
                                      text: 'Tasdiqlash'.tr.capitalizeFirst!)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.add),
                label: Text("To'lov qo'shish")),
          ):SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('LeaderStudents')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                List payments = snapshot.data!.docs
                    .where((el) => el['items']['uniqueId'] == uniqueId)
                    .toList();
                return payments[0]['items']['payments'].isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          children: [

                            SizedBox(height: 8,),
                            for (int i = 0;
                                i < payments[0]['items']['payments'].length;
                                i++)
                              Container(
                                width: Get.width,
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: CupertinoColors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Colors.black, width: .5)),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "To'lov qilingan sana: ",
                                              style: appBarStyle.copyWith(
                                                  fontSize: 10,
                                                  color:
                                                      CupertinoColors.systemGrey),
                                            ),
                                            Text(
                                              convertDate(
                                                  "${payments[0]['items']['payments'][i]['paidDate']}"),
                                              style: appBarStyle.copyWith(
                                                  color: Colors.blue,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "To'lov miqdori: ",
                                              style: appBarStyle.copyWith(
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              " ${payments[0]['items']['payments'][i]['paidSum']} so'm",
                                              style: appBarStyle.copyWith(
                                                  color: Colors.green,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                   GetStorage().read('isLogged') !='student'  ?   Container(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          insetPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 16),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0)),
                                                          //this right here
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      16),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              width: Get.width,
                                                              height: Get.height /
                                                                  3,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "O'zgartirish"),
                                                                  TextFormField(
                                                                      inputFormatters: [
                                                                        ThousandSeparatorInputFormatter(),
                                                                      ],
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      controller:
                                                                          studentController
                                                                              .payment,
                                                                      decoration:
                                                                          buildInputDecoratione(
                                                                              "To'lov miqdori"),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return "Maydonlar bo'sh bo'lmasligi kerak";
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  Row(
                                                                    children: [
                                                                      Obx(
                                                                        () => Text(
                                                                            'To\'lov qilingan sana:  ${studentController.paidDate.value}'),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            studentController
                                                                                .showDate(studentController.paidDate);
                                                                          },
                                                                          icon: Icon(
                                                                              Icons.calendar_month))
                                                                    ],
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (_formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                        print(id);
                                                                        print(payments[0]['items']['payments']
                                                                                [
                                                                                i]
                                                                            [
                                                                            'id']);
                                                                        studentController.editPayment(
                                                                            id,
                                                                            payments[0]['items']['payments'][i]
                                                                                [
                                                                                'id']);
                                                                      }
                                                                    },
                                                                    child: Obx(() => CustomButton(
                                                                        isLoading: studentController
                                                                            .isLoading
                                                                            .value,
                                                                        text: 'Edit'
                                                                            .tr
                                                                            .capitalizeFirst!)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.purple,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    studentController.deletePayment(id,
                                                        payments[0]['items']['payments'][i]
                                                        [
                                                        'id']);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  )),
                                            ],
                                          ),
                                        ):SizedBox()
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ],
                        ),
                    )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Image.asset(
                              'assets/fee_not_charged.png',
                              width: 222,
                            ),
                            Text(
                              '${name}'.capitalizeFirst! +
                                  " " +
                                  "${surname}".capitalizeFirst! +
                                  " da to'lovlar mavjud emas ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      );
              }
              // If no data available

              else {
                return Text('No data'); // No data available
              }
            }),
      ),
    );
  }
}
