import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/job.dart';
import 'package:monitoring_pegawai/page/admin/add_update_job.dart';

class ListPekerjaan extends StatefulWidget {
  @override
  _ListPekerjaanState createState() => _ListPekerjaanState();
}

class _ListPekerjaanState extends State<ListPekerjaan> {
  List<Job> _listJob = [];

  void getJob() async {
    _listJob = await EventDB.getJob();
    setState(() {});
  }

  @override
  void initState() {
    getJob();
    super.initState();
  }

  void showOption(Job job) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
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
      case 'update':
        Get.to(AddUpdateJob(job: job))?.then((value) => getJob());
        break;
      case 'delete':
        EventDB.deleteJob(job.idJob!).then((value) => getJob());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listJob.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
                itemCount: _listJob.length,
                itemBuilder: (context, index) {
                  Job job = _listJob[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.black54,
                    ),
                    title: Text(job.jobName ?? ''),
                    subtitle: Text(job.salary ?? ''),
                    trailing: IconButton(
                      onPressed: () => showOption(job),
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
            onPressed: () => Get.to(AddUpdateJob())?.then((value) => getJob()),
            backgroundColor: Asset.colorAccent,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
