import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/auth/login.dart';
import '../../screens/parents/parent_home_screen.dart';

class FireAuth extends GetxController {
  TextEditingController teacherId = TextEditingController();
  RxBool isLoading = false.obs;
  var box = GetStorage();
  RxBool isBanned = false.obs;


  // 1716225252433



  void logOut() async {
    isLoading.value = true;
    try {
      box.write('isLogged', null);
      Get.off(Login());
      isLoading.value = true;
    } catch (e) {
      Get.snackbar(
        "Logout",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
    isLoading.value = false;
  }



  Future<void> LoginStudent(String studentId) async {
    isLoading.value = true;

    try {
      // Reference to the collection
      CollectionReference users = FirebaseFirestore.instance.collection('LeaderStudents');

      // Query the collection where the 'name' field is equal to 'John'
      QuerySnapshot querySnapshot = await users.where('items.uniqueId', isEqualTo: studentId).get();

      print("Users $users");
      // Iterate through the documents in the query snapshot
      for (var doc in querySnapshot.docs) {
      box.write('student_doc_id', doc.id);
      box.write('isLogged', 'student');
      Get.offAll(ParentsAdminHomeScreen());
      isLoading.value = false;

      }
      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Login Failed",
        "Foydalanuvchi topilmadi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );    }
  }


}
