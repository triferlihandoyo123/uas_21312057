import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
              Center(
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/UNIVERSITASTEKNOKRAT.png/1200px-UNIVERSITASTEKNOKRAT.png',
                width: 150, // Lebar gambar (opsional)
                height: 150, // Tinggi gambar (opsional)
                fit: BoxFit
                    .cover, // Cara gambar menyesuaikan ukuran widget (opsional)
              ),
            ),
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: controller.cpass,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.green, // Ubah warna latar belakang (background color)
                onPrimary: Colors.white, // Ubah warna teks
              ),
              onPressed: () => cAuth.signup(
                controller.cEmail.text,
                controller.cpass.text,
              ),
              child: Text("SignUp"),
            ),
          ],
        ),
      ),
    );
  }
}
