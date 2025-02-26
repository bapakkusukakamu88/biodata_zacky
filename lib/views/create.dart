import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:biodata_zacky/models/msiswa.dart';
import 'package:biodata_zacky/models/api.dart';
//import 'package:biodata_zacky/views/details.dart';
//import 'package:biodata_zacky/views/create.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => Homestate();
}

final fromkey = GlobalKey<FormState>();

TextEditingController nisController = new TextEditingController();
TextEditingController namaController = new TextEditingController();
TextEditingController tpController = new TextEditingController();
TextEditingController tgController = new TextEditingController();
TextEditingController kelaminController = new TextEditingController();
TextEditingController agamaController = new TextEditingController();
TextEditingController alamatController = new TextEditingController();

Future createSw() async {
  return await http.post(
    Uri.parse(BaseUrl.tambah),
    body: {
      "nis": nisController.text,
      "nama": namaController.text,
      "tp": tpController.text,
      "tg": tgController.text,
      "kelamin": kelaminController.text,
      "agama": agamaController.text,
      "alamat": alamatController.text,
    },
  );
}

void _onConfirm(context) async {
  http.Response response = await createSw();
  final data = json.decode(response.body);
  if (data['success']) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Tambah Siswa"),
      centerTitle: true,
      backgroundColor: Colors.blue,
    ),
    bottomNavigationBar: BottomAppBar(
      child: ElevatedButton(
        child: Text("Simpan"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.green,
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            //print(context);
            print("OK SUKSES");
            _onConfirm(context);
          }
        },
      ),
    ),
    body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: AppForm(
              formkey: formkey,
              nisController: nisController,
              namaController: namaController,
              tpController: tpController,
              tgController: tgController,
              kelaminController: kelaminController,
              agamaController: agamaController,
              alamatController: alamatController,
            ),
          ),
        ),
    ),
  );
}