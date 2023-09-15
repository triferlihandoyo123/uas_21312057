import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_21312057/app/controllers/auth_controller.dart';
import 'package:uas_21312057/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final cAuth = Get.find<AuthController>();

  void showOption(id) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(
                Routes.UPDATE_PRODUCT,
                arguments: id,
              );
            },
            title: Text('Update'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              controller.deleteProduct(id);
            },
            title: Text('Delete'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/UNIVERSITASTEKNOKRAT.png/1200px-UNIVERSITASTEKNOKRAT.png', // Ganti dengan URL gambar yang ingin Anda gunakan
              width: 40, // Sesuaikan lebar gambar sesuai kebutuhan
              height: 40, // Sesuaikan tinggi gambar sesuai kebutuhan
              fit: BoxFit.cover, // Sesuaikan tipe fit sesuai kebutuhan
            ),
            const SizedBox(width: 10), // Jarak antara gambar dan teks
            const Text('Data Mahasiswa'),
          ],
        ),
        centerTitle: false, // Tidak perlu lagi mengatur centerTitle ke true
        actions: [
          IconButton(onPressed: () => cAuth.logout(), icon: Icon(Icons.logout))
        ],
        toolbarHeight: 70, // Sesuaikan tinggi AppBar sesuai kebutuhan
      ),

      //1.Menampilkan data tidak realtime
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //   future: controller.GetData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // mengambil data
      //       var listAllDocs = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: listAllDocs.length,
      //         itemBuilder: (context, index) => ListTile(
      //           title: Text(
      //               "${(listAllDocs[index].data() as Map<String, dynamic>)["name"]}"),
      //           subtitle: Text(
      //               "${(listAllDocs[index].data() as Map<String, dynamic>)["price"]}"),
      //         ),
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),

      //2.Menampilkan data secara realtime
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: FirebaseFirestore.instance.collection('mahasiswa_21312057').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllDocs.length,
              itemBuilder: (context, index) {
                var data = listAllDocs[index].data() as Map<String, dynamic>;
                return Container(
                  margin: EdgeInsets.only(top: 8,right: 10,left: 10),
                  decoration: BoxDecoration(
                    color: Colors
                        .blue, // Ganti dengan warna latar belakang yang Anda inginkan
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius border sesuai kebutuhan
                  ),
                  // Ganti dengan warna latar belakang yang Anda inginkan

                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.yellow,
                    ),
                    title: Text(
                      "Nama: ${data["nama"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("NPM: ${data["npm"]}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () => showOption(listAllDocs[index].id),
                      icon: Icon(Icons.more_vert),
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        focusColor: Colors.white, // Ikon "Tambah"
      ),
    );
  }
}
