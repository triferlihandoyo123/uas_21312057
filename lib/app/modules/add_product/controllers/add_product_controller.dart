import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_21312057/app/modules/add_product/controllers/add_product_controller.dart';


class AddMahasiswaController extends GetxController {
  late TextEditingController cNPM;
  late TextEditingController cNama;
  late TextEditingController cAlamat;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addMahasiswa(String npm, String nama, String alamat) async {
    CollectionReference mahasiswa = firestore.collection("mahasiswa_21312057");
    try {
      await mahasiswa.add({
        "npm": npm,
        "nama": nama,
        "alamat": alamat,
      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menyimpan data",
        onConfirm: () {
          cNPM.clear();
          cNama.clear();
          cAlamat.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal menyimpan data Mahasiswa.",
      );
    }
  }

  @override
  void onInit() {
    cNama = TextEditingController();
    cAlamat = TextEditingController();
    cNPM = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    cNama.dispose();
    cAlamat.dispose();
    cNPM.dispose();
    super.onClose();
  }
}
