import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/page/monitoring/detail_task.dart';
import 'package:monitoring_pegawai/page/pegawai/update_progress.dart';

class ListTask extends StatefulWidget {
  @override
  _ListTaskState createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  CUser _cUser = Get.put(CUser());
  List<Task> _listTask = [];

  void getTask() async {
    _listTask = await EventDB.getTask(_cUser.user.idUser!);
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
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
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
        Get.to(DetailTask(task: task))?.then((value) => getTask());
        break;
      case 'update':
        Get.to(UpdateProgress(task: task))?.then((value) => getTask());
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
    double width = MediaQuery.of(context).size.width - 32;
    return _listTask.length > 0
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
                              border: Border.all(width: 1, color: Colors.grey),
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
        : Center(child: Text('Kosong'));
  }
}
