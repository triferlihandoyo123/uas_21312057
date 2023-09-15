import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_21312057/app/controllers/auth_controller.dart';
import 'package:uas_21312057/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Universitas Teknokrat Indonesia",style: TextStyle(
        //   color: Colors.yellow
        // ),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIDAM",
                  style: TextStyle(
                    color: Colors.red, // Ubah warna teks sesuai keinginan Anda
                    fontSize: 30, // Ubah ukuran font sesuai keinginan Anda
                    fontWeight: FontWeight.bold, // Membuat teks cetak tebal
                    // Anda juga dapat menambahkan dekorasi lainnya seperti fontFamily, dll.
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("(Sistem Informasi Data Mahasiswa)",
              style: TextStyle(
                color: Colors.green,
                fontSize: 13,
                fontWeight: FontWeight.bold
              ),)],
            ),
            SizedBox(height: 15),
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
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                child: Text("Reset Password"),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.green, // Ubah warna latar belakang (background color)
                onPrimary: Colors.white, // Ubah warna teks
              ),
              onPressed: () => cAuth.login(
                controller.cEmail.text,
                controller.cpass.text,
              ),
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum Punya Akun?"),
                TextButton(
                    onPressed: () => Get.toNamed(Routes.SIGNUP),
                    child: Text("SignUp")),
                SizedBox(height: 10),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => cAuth.loginGoogle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login With Google"),
                  SizedBox(width: 5),
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png', // Ganti dengan URL gambar logo Google
                    height: 26,
                    width: 26,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
