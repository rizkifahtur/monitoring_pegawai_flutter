import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/model/pendapatan.dart';
import 'package:monitoring_pegawai/model/resi.dart';

class DetailPendapatan extends StatelessWidget {
  final Pendapatan pendapatan;

  DetailPendapatan({required this.pendapatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pendapatan'),
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
          Text('Pendapatan'),
          Text(
            pendapatan.pendapatan ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Keterangan'),
          Text(pendapatan.keterangan ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Tanggal'),
          Text(pendapatan.date ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
