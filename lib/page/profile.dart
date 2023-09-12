import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';

class Profile extends StatelessWidget {
  CUser _cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    var styleText = TextStyle(
      fontSize: 18,
    );
    return ListView(
      children: [
        ListTile(
          tileColor: Asset.colorSecondary,
          title: Text('Profile'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Obx(() => Text('Nama : ${_cUser.user.name}', style: styleText)),
              SizedBox(height: 8),
              Obx(() => Text('No.HP : ${_cUser.user.nohp}', style: styleText)),
              SizedBox(height: 8),
              Obx(() =>
                  Text('Alamat : ${_cUser.user.address}', style: styleText)),
              SizedBox(height: 30),
            ],
          ),
        ),
        ListTile(
          tileColor: Asset.colorSecondary,
          title: Text('Pekerjaan'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Obx(() => Text('Nama Pekerjaan: ${_cUser.user.jobName}',
                  style: styleText)),
              SizedBox(height: 8),
              Obx(() => Text('Gaji : ${_cUser.user.salary}', style: styleText)),
            ],
          ),
        ),
      ],
    );
  }
}
