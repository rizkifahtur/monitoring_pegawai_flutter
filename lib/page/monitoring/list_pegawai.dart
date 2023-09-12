import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/monitoring/detail_profile.dart';
import 'package:monitoring_pegawai/page/operator/add_update_pegawai.dart';

class ListPegawai extends StatefulWidget {
  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  CUser _cUser = Get.put(CUser());
  List<User> _listUser = [];

  void getPegawai() async {
    _listUser = await EventDB.getUser('Pegawai');
    setState(() {});
  }

  void showOption(User user) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'detail'),
              title: Text('Detail'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'delete'),
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            ),
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'detail':
        Get.to(DetailProfile(user: user))?.then((value) => getPegawai());
        break;
      case 'update':
        Get.to(AddUpdatePegawai(user: user))?.then((value) => getPegawai());
        break;
      case 'delete':
        EventDB.deleteUser(user.idUser!).then((value) => getPegawai());
        break;
    }
  }

  @override
  void initState() {
    getPegawai();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listUser.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70),
                itemCount: _listUser.length,
                itemBuilder: (context, index) {
                  User user = _listUser[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.black54,
                    ),
                    title: Text(user.name ?? ''),
                    subtitle: Text('Id User : ${user.idUser}'),
                    trailing: IconButton(
                      onPressed: () => showOption(user),
                      icon: Icon(Icons.more_vert),
                    ),
                  );
                },
              )
            : Center(child: Text('Kosong')),
        Obx(
          () => _cUser.user.role == 'Operator'
              ? Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () => Get.to(AddUpdatePegawai())
                        ?.then((value) => getPegawai()),
                    backgroundColor: Asset.colorAccent,
                    child: Icon(Icons.add),
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
