import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/model/leaderboard.dart';
import 'package:monitoring_pegawai/model/notif.dart';

class DetailLeaderboard extends StatelessWidget {
  final Leaderboard leaderboard;

  DetailLeaderboard({required this.leaderboard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Leaderboard'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.green, Colors.blue])),
        ),
        titleSpacing: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Nama : '),
          Text(
            leaderboard.name ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Jumlah Score'),
          Text(leaderboard.score ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('ID User'),
          Text(
            leaderboard.idUser ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
