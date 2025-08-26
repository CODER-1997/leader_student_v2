import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/auth/login_controller.dart';

class Login extends StatelessWidget {
  Rx isLogin = true.obs;
  Rx isVisible = false.obs;

  FireAuth auth = Get.put(FireAuth());
  GetStorage box = GetStorage();
  RxBool isStudent = false.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(color: Colors.green),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Kirish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: auth.teacherId,
                          validator:
                              (value) {
                            if (value!
                                .isEmpty) {
                              return "Maydonlar bo'sh bo'lmasligi kerak";
                            }
                            return null;
                          },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText:  "Talaba ID ni kiriting",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {

                  if(_formKey .currentState! .validate()){
                    auth.LoginStudent(auth.teacherId.text.removeAllWhitespace);

                  }
                      },
                      child: Text('kirish'.tr.capitalizeFirst!),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                    ),

                  ],
                ),
              ),
              Center(
                child: Visibility(
                  visible: auth.isLoading.value == true,
                  child: Container(
                    height: 120,
                    width: Get.width / 2,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 32,
                        ),
                        Text('Login.....')
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
