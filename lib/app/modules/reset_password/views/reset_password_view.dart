import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_21312057/app/controllers/auth_controller.dart';
import 'package:uas_21312057/app/routes/app_pages.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final cEmail = TextEditingController();
  final cPass = TextEditingController();
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              controller: cEmail,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => cAuth.resetPassword(cEmail.text),
              child: Text("Reset Password"),
              style: ElevatedButton.styleFrom(
                primary: Colors
                    .green, // Atur warna latar belakang tombol sesuai kebutuhan
                onPrimary: Colors.white, // Atur warna teks pada tombol
                padding:
                    EdgeInsets.all(16), // Atur padding tombol sesuai kebutuhan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Atur border radius tombol sesuai kebutuhan
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah Punya Akun?"),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.LOGIN),
                  child: Text("Klik Disini"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
