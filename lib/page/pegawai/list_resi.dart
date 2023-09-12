import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/resi.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/pegawai/add_update_resi.dart';
import 'package:monitoring_pegawai/page/pegawai/detail_resi.dart';

class ListResi extends StatefulWidget {
  @override
  _ListResiState createState() => _ListResiState();
}

class _ListResiState extends State<ListResi> {
  List<Resi> _listResi = [];
  CUser _cUser = Get.put(CUser());

  void getResi() async {
    _listResi = await EventDB.getResi();
    setState(() {});
  }

  void getUser() async {
    User? user = await EventPref.getUser();
    if (user != null) {
      _cUser.setUser(user);
    }
  }

  @override
  void initState() {
    getResi();
    super.initState();
  }

  void showOption(Resi resi) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'detail'),
              title: Text('Detail'),
            ),
            Obx(() => _cUser.user.role == 'Admin'
                ? ListTile(
                    onTap: () => Get.back(result: 'delete'),
                    title: Text('Delete'),
                  )
                : AbsorbPointer(
                    absorbing: false,
                  )),
            Obx(() => _cUser.user.role == 'Operator'
                ? ListTile(
                    onTap: () => Get.back(result: 'delete'),
                    title: Text('Delete'),
                  )
                : AbsorbPointer(
                    absorbing: false,
                  )),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            ),
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'detail':
        Get.to(DetailResi(resi: resi))?.then((value) => getResi());
        break;
      case 'delete':
        EventDB.deleteResi(resi.idResi!).then((value) => getResi());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listResi.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
                itemCount: _listResi.length,
                itemBuilder: (context, index) {
                  Resi resi = _listResi[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.black54,
                    ),
                    isThreeLine: true,
                    title: Text(resi.kdResi ?? ''),
                    subtitle: Text(resi.keterangan ?? ''),
                    trailing: IconButton(
                      onPressed: () => showOption(resi),
                      icon: Icon(Icons.more_vert),
                    ),
                  );
                },
              )
            : Center(child: Text('Kosong')),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () =>
                Get.to(AddUpdateResi())?.then((value) => getResi()),
            backgroundColor: Asset.colorAccent,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
