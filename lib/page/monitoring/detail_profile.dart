import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_leaderboard.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/leaderboard.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/monitoring/detail_task.dart';
import 'package:monitoring_pegawai/page/operator/add_update_task.dart';

class DetailProfile extends StatefulWidget {
  final User user;
  DetailProfile({required this.user});

  @override
  _DetailProfileState createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  CUser _cUser = Get.put(CUser());
  CLeaderboard cLeaderboard = Get.put(CLeaderboard());
  List<Leaderboard> _listLeaderboard = [];
  List<Task> _listTask = [];

  void getTask() async {
    _listTask = await EventDB.getTask(widget.user.idUser!);
    setState(() {});
  }

  void showOption(Task task) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'detail'),
              title: Text('Detail'),
            ),
            Obx(() => _cUser.user.role == 'Admin'
                ? SizedBox()
                : ListTile(
                    onTap: () => Get.back(result: 'update'),
                    title: Text('Update'),
                  )),
            Obx(() => _cUser.user.role == 'Admin'
                ? SizedBox()
                : ListTile(
                    onTap: () => Get.back(result: 'delete'),
                    title: Text('Delete'),
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
        Get.to(DetailTask(task: task))?.then((value) => getTask());
        break;
      case 'update':
        Get.to(AddUpdateTask(idUser: task.idUser!, task: task))
            ?.then((value) => getTask());
        break;
      case 'delete':
        EventDB.deleteTask(task.idTask!).then((value) => getTask());
        break;
    }
  }

  @override
  void initState() {
    getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var styleText = TextStyle(
      fontSize: 18,
    );
    double width = MediaQuery.of(context).size.width - 32;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.green, Colors.blue])),
        ),
        title: Text('Detail Profile'),
      ),
      body: ListView(
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
                Text('Nama : ${widget.user.name}', style: styleText),
                SizedBox(height: 8),
                Text('No.HP : ${widget.user.nohp}', style: styleText),
                SizedBox(height: 8),
                Text('Alamat : ${widget.user.address}', style: styleText),
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
                Text('Nama Pekerjaan: ${widget.user.jobName}',
                    style: styleText),
                SizedBox(height: 8),
                Text('Gaji : ${widget.user.salary}', style: styleText),
                SizedBox(height: 30),
              ],
            ),
          ),
          ListTile(
            tileColor: Asset.colorSecondary,
            title: Text('Kompetisi'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text('Jenis: ${widget.user.reward}', style: styleText),
                SizedBox(height: 8),
                Text('Keterangan : ${widget.user.description}',
                    style: styleText),
                SizedBox(height: 30),
              ],
            ),
          ),
          widget.user.role == 'Pegawai'
              ? Obx(
                  () => ListTile(
                    tileColor: Asset.colorSecondary,
                    title: Text('Tugas Report'),
                    trailing: _cUser.user.role == 'Operator'
                        ? IconButton(
                            onPressed: () {
                              Get.to(AddUpdateTask(idUser: widget.user.idUser!))
                                  ?.then((value) => getTask());
                            },
                            icon: Icon(Icons.add_box),
                          )
                        : SizedBox(),
                  ),
                )
              : SizedBox(),
          _listTask.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 70),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listTask.length,
                  itemBuilder: (context, index) {
                    Task task = _listTask[index];
                    double progress = double.parse(task.progress ?? '0');
                    return GestureDetector(
                      onTap: () => showOption(task),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  task.taskName ?? '',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${progress.round()}%',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Stack(
                              children: [
                                Container(
                                  width: width,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: progress / 100 * width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Asset.colorAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Obx(
                      () => Text(_cUser.user.role == 'Admin' ? '' : 'Kosong'))),
        ],
      ),
    );
  }
}
