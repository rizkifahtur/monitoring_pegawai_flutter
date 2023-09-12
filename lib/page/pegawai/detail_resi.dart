import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/model/resi.dart';

class DetailResi extends StatelessWidget {
  final Resi resi;

  DetailResi({required this.resi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Resi'),
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
          Text('Kode Resi'),
          Text(
            resi.kdResi ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Keterangan'),
          Text(resi.keterangan ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Tanggal'),
          Text(resi.date ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
