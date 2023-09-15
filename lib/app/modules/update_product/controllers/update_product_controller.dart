import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateMahasiswaController extends GetxController {
  late TextEditingController cNPM;
  late TextEditingController cNama;
  late TextEditingController cAlamat;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("mahasiswa_21312057").doc(id);
    return docRef.get();
  }

  void updateMahasiswa(String npm, String nama, String alamat, String id) async {
    DocumentReference mahasiswaById = firestore.collection("mahasiswa_21312057").doc(id);

    try {
      await mahasiswaById.update({
        "npm": npm,
        "nama": nama,
        "alamat": alamat,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Mengubah Data Mahasiswa.",
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
        middleText: "Gagal Mengubah Mahasiswa.",
      );
    }
  }

  @override
  void onInit() {
    cNPM = TextEditingController();
    cNama = TextEditingController();
    cAlamat = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    cNPM.dispose();
    cNama.dispose();
    cAlamat.dispose();
    super.onClose();
  }
}
