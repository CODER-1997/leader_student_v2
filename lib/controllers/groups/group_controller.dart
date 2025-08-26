import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/utils.dart';
import '../../models/group_model.dart';

class GroupController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController GroupName = TextEditingController();
  TextEditingController GroupEdit = TextEditingController();

  setValues(
    String name,
  ) {
    GroupEdit = TextEditingController(text: name);
  }

  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('LeaderGroups');
  RxInt order = 0.obs;
  GetStorage box = GetStorage();

  void addNewGroup() async {
    Get.back();
    isLoading.value = true;
    try {
      GroupModel newData = GroupModel(
        name: GroupName.text,
        uniqueId: generateUniqueId(),
        order: order.value,
        teacherId: box.read('teacherId'),
        perStudentYearlyFee: box.read('teacherId') == "323232" ? "3 000 000":box.read('perStudentYearlyFee'),
      );
      // Create a new document with an empty list
      await _dataCollection.add({
        'items': newData.toMap(),
      });
      // Get.snackbar(
      //   "Success !",
      //   "New group added successfully !",
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.TOP,
      // );
      isLoading.value = false;
      GroupName.clear();
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error:${e}',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;

// Firestore
  }

  //
  void editGroup(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =
          _firestore.collection('LeaderGroups').doc(documentId);

      // Update the desired field
      await documentReference.update({
        'items.name': GroupEdit.text,
      });
      Get.back();
      isLoading.value = false;
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void addFeature(String documentId, int order) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =
          _firestore.collection('LeaderGroups').doc(documentId);

      // Update the desired field
      await documentReference.update({
        'items.order': order,
      });
      isLoading.value = false;
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void deleteGroup(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =
          _firestore.collection('LeaderGroups').doc(documentId);

      // Update the desired field
      await documentReference.delete();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
