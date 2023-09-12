import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/admin/add_update_operator.dart';
import 'package:monitoring_pegawai/page/monitoring/detail_profile.dart';

class ListOperator extends StatefulWidget {
  @override
  _ListOperatorState createState() => _ListOperatorState();
}

class _ListOperatorState extends State<ListOperator> {
  List<User> _listUser = [];

  void getOperator() async {
    _listUser = await EventDB.getUser('Operator');
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
        Get.to(DetailProfile(user: user));
        break;
      case 'update':
        Get.to(AddUpdateOperator(user: user))?.then((value) => getOperator());
        break;
      case 'delete':
        EventDB.deleteUser(user.idUser!).then((value) => getOperator());
        break;
    }
  }

  @override
  void initState() {
    getOperator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listUser.length > 0
            ? ListView.builder(
                itemCount: _listUser.length,
                itemBuilder: (context, index) {
                  User user = _listUser[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.black54,
                    ),
                    title: Text(user.name ?? ''),
                    trailing: IconButton(
                      onPressed: () => showOption(user),
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
                Get.to(AddUpdateOperator())?.then((value) => getOperator()),
            backgroundColor: Asset.colorAccent,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
