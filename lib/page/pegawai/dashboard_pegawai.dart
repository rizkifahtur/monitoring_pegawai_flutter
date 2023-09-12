import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/login.dart';
import 'package:monitoring_pegawai/page/pegawai/list_pendapatan.dart';
import 'package:monitoring_pegawai/page/pegawai/list_resi.dart';
import 'package:monitoring_pegawai/page/pegawai/list_task.dart';
import 'package:monitoring_pegawai/page/profile.dart';
import 'package:monitoring_pegawai/page/profile_pegawai.dart';

class DashboardPegawai extends StatefulWidget {
  @override
  _DashboardOperatorState createState() => _DashboardOperatorState();
}

class _DashboardOperatorState extends State<DashboardPegawai> {
  CUser _cUser = Get.put(CUser());
  int _index = 0;
  List<Map> _fragment = [
    {'title': 'Profile', 'view': ProfilePegawai()},
    {'title': 'Daftar Tugas', 'view': ListTask()},
    {'title': 'Data Pendapatan Toko', 'view': ListPendapatan()},
    {'title': 'Data Resi', 'view': ListResi()},
  ];

  void getUser() async {
    User? user = await EventPref.getUser();
    if (user != null) {
      _cUser.setUser(user);
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.green, Colors.blue])),
        ),
        title: Text(_fragment[_index]['title']),
      ),
      body: _fragment[_index]['view'],
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Asset.colorSecondary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      _cUser.user.name ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Asset.colorPrimaryDark,
                      ),
                    )),
                SizedBox(height: 8),
                Text(
                  'Role : Pegawai',
                  style: TextStyle(
                    fontSize: 16,
                    color: Asset.colorPrimaryDark,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              setState(() => _index = 0);
              Get.back();
            },
            leading: Icon(
              Icons.people,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
          ListTile(
            onTap: () {
              setState(() => _index = 1);
              Get.back();
            },
            leading: Icon(
              Icons.work,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Daftar Tugas',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
          Obx(
            () => _cUser.user.idJob == 'csr'
                ? ListTile(
                    onTap: () {
                      setState(() => _index = 2);
                      Get.back();
                    },
                    leading: Icon(
                      Icons.work,
                      color: Asset.colorPrimaryDark,
                    ),
                    title: Text(
                      'Data Pendapatan Toko',
                      style: TextStyle(color: Asset.colorPrimaryDark),
                    ),
                    trailing: Icon(Icons.navigate_next,
                        color: Asset.colorPrimaryDark),
                  )
                : AbsorbPointer(
                    absorbing: false,
                  ),
          ),
          Obx(
            () => _cUser.user.idJob == 'inv'
                ? ListTile(
                    onTap: () {
                      setState(() => _index = 3);
                      Get.back();
                    },
                    leading: Icon(
                      Icons.work,
                      color: Asset.colorPrimaryDark,
                    ),
                    title: Text(
                      'Data Resi',
                      style: TextStyle(color: Asset.colorPrimaryDark),
                    ),
                    trailing: Icon(Icons.navigate_next,
                        color: Asset.colorPrimaryDark),
                  )
                : AbsorbPointer(
                    absorbing: false,
                  ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              EventPref.clear();
              Get.off(Login());
            },
            leading: Icon(
              Icons.logout,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
        ],
      ),
    );
  }
}
