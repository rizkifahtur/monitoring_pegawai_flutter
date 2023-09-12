import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/leaderboard.dart';
import 'package:monitoring_pegawai/model/notif.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/monitoring/detail_notif.dart';
import 'package:monitoring_pegawai/page/pegawai/list_task.dart';
import 'package:badges/badges.dart';

class ListNotif extends StatefulWidget {
  @override
  _ListNotifState createState() => _ListNotifState();
}

class _ListNotifState extends State<ListNotif> {
  List<Notif> _listNotif = [];

  void getNotif() async {
    _listNotif = await EventDB.getNotif();
    setState(() {});
  }

  void showOption(Notif notif) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'detail'),
              title: Text('Detail'),
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
        Get.to(DetailNotif(notif: notif))?.then((value) => getNotif());
        break;
    }
  }

  @override
  void initState() {
    getNotif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listNotif.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
                itemCount: _listNotif.length,
                itemBuilder: (context, index) {
                  Notif notif = _listNotif[index];
                  return ListTile(
                    onTap: () => showOption(notif),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.black54,
                    ),
                    isThreeLine: true,
                    title: Text(notif.taskName ?? ''),
                    subtitle: Text(
                        'Id User : ${notif.idUser} Progress : ${notif.progress}'),
                  );
                },
              )
            : Center(child: Text('Kosong')),
      ],
    );
  }
}
