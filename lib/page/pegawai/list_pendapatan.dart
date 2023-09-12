import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/pendapatan.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/pegawai/add_update_pendapatan.dart';
import 'package:monitoring_pegawai/page/pegawai/detail_pendapatan.dart';

class ListPendapatan extends StatefulWidget {
  @override
  _ListPendapatanState createState() => _ListPendapatanState();
}

class _ListPendapatanState extends State<ListPendapatan> {
  List<Pendapatan> _listPendapatan = [];
  CUser _cUser = Get.put(CUser());

  void getPendapatan() async {
    _listPendapatan = await EventDB.getPendapatan();
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
    getPendapatan();
    super.initState();
  }

  void showOption(Pendapatan pendapatan) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'detail'),
              title: Text('Detail'),
            ),
            Obx(
              () => _cUser.user.role == 'Admin'
                  ? ListTile(
                      onTap: () => Get.back(result: 'delete'),
                      title: Text('Delete'),
                    )
                  : AbsorbPointer(
                      absorbing: false,
                    ),
            ),
            Obx(
              () => _cUser.user.role == 'Operator'
                  ? ListTile(
                      onTap: () => Get.back(result: 'delete'),
                      title: Text('Delete'),
                    )
                  : AbsorbPointer(
                      absorbing: false,
                    ),
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
        Get.to(DetailPendapatan(pendapatan: pendapatan))
            ?.then((value) => getPendapatan());
        break;
      case 'delete':
        EventDB.deletePendapatan(pendapatan.idIncome!)
            .then((value) => getPendapatan());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listPendapatan.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
                itemCount: _listPendapatan.length,
                itemBuilder: (context, index) {
                  Pendapatan pendapatan = _listPendapatan[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.black54,
                    ),
                    isThreeLine: true,
                    title: Text(pendapatan.pendapatan ?? ''),
                    subtitle: Text(pendapatan.keterangan ?? ''),
                    trailing: IconButton(
                      onPressed: () => showOption(pendapatan),
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
                Get.to(AddUpdatePendapatan())?.then((value) => getPendapatan()),
            backgroundColor: Asset.colorAccent,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
