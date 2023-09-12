import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:monitoring_pegawai/controller/c_leaderboard.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/leaderboard.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/monitoring/detail_leaderboard.dart';
import 'package:monitoring_pegawai/page/pegawai/list_task.dart';

class ListLeaderboard extends StatefulWidget {
  @override
  _ListLeaderboardState createState() => _ListLeaderboardState();
}

class _ListLeaderboardState extends State<ListLeaderboard> {
  List<Leaderboard> _listLeaderboard = [];
  CUser _cUser = Get.put(CUser());
  List<Task> _listTask = [];
  void getLeaderboard() async {
    _listLeaderboard = await EventDB.getLeaderboard();
    setState(() {});
  }

  void resetData() async {
    await EventDB.resetData();
    getLeaderboard();
    Get.back();
    setState(() {});
  }

  void showOption(Leaderboard leaderboard) async {
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
        Get.to(DetailLeaderboard(leaderboard: leaderboard))
            ?.then((value) => getLeaderboard());
        break;
    }
  }

  void getUser() async {
    User? user = await EventPref.getUser();
    if (user != null) {
      _cUser.setUser(user);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Get.back(),
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () => resetData(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Apakah Anda Yakin ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    getLeaderboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_listLeaderboard.length > 0)
          ListView.builder(
            padding: EdgeInsets.only(
              bottom: 70,
            ),
            itemCount: _listLeaderboard.length,
            itemBuilder: (context, index) {
              Leaderboard leaderboard = _listLeaderboard[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                  backgroundColor: Colors.black54,
                ),
                isThreeLine: true,
                title: Text(leaderboard.name ?? ''),
                subtitle: Text(leaderboard.score ?? ''),
                onTap: () => showOption(leaderboard),
              );
            },
          )
        else
          Center(child: Text('Kosong')),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: const Text(
                    'Reset Score',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
