import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/page/monitoring/list_leaderboard.dart';
import 'package:monitoring_pegawai/page/monitoring/list_notifikasi.dart';
import 'package:monitoring_pegawai/page/monitoring/list_pegawai.dart';
import 'package:monitoring_pegawai/page/login.dart';
import 'package:monitoring_pegawai/page/pegawai/list_pendapatan.dart';
import 'package:monitoring_pegawai/page/pegawai/list_resi.dart';
import 'package:monitoring_pegawai/page/pegawai/luasPersegi.dart';
import 'package:monitoring_pegawai/page/profile.dart';

class DashboardOperator extends StatefulWidget {
  @override
  _DashboardOperatorState createState() => _DashboardOperatorState();
}

class _DashboardOperatorState extends State<DashboardOperator> {
  CUser _cUser = Get.put(CUser());
  int _index = 0;
  List<Map> _fragment = [
    {'title': 'Profile', 'view': Profile()},
    {'title': 'Daftar Pegawai', 'view': ListPegawai()},
    {'title': 'Papan Peringkat (Pass Score:19.000)', 'view': ListLeaderboard()},
    {'title': 'Data Pendapatan', 'view': ListPendapatan()},
    {'title': 'Data Resi', 'view': ListResi()},
    {'title': 'Luas Persegi', 'view': luasPersegi()},
    {'title': 'Update Progress Pekerjaan', 'view': ListNotif()},
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
                  'Role : Operator',
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
              setState(() => _index = 5);
              Get.back();
            },
            leading: Icon(
              Icons.notifications,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Update Progress Pekerjaan',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
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
              Icons.people,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Daftar Pegawai',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
          ListTile(
            onTap: () {
              setState(() => _index = 2);
              Get.back();
            },
            leading: Icon(
              Icons.analytics,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Papan Peringkat (Pass Score:19.000)',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
          ListTile(
            onTap: () {
              setState(() => _index = 3);
              Get.back();
            },
            leading: Icon(
              Icons.work,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Data Pendapatan',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
          ListTile(
            onTap: () {
              setState(() => _index = 4);
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
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
          ),
          ListTile(
            onTap: () {
              setState(() => _index = 5);
              Get.back();
            },
            leading: Icon(
              Icons.work,
              color: Asset.colorPrimaryDark,
            ),
            title: Text(
              'Luas Persegi',
              style: TextStyle(color: Asset.colorPrimaryDark),
            ),
            trailing: Icon(Icons.navigate_next, color: Asset.colorPrimaryDark),
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
