import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
 final cEmail=TextEditingController();
 final cpass=TextEditingController();

  @override
  void onClose(){
    cEmail.dispose();
    cpass.dispose();
    super.onClose();
  }

}
