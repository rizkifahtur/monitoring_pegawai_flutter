import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/job.dart';
import 'package:monitoring_pegawai/model/resi.dart';
import 'package:monitoring_pegawai/widget/info.dart';

class AddUpdateResi extends StatefulWidget {
  final Resi? resi;

  AddUpdateResi({this.resi});

  @override
  _AddUpdateResiState createState() => _AddUpdateResiState();
}

class _AddUpdateResiState extends State<AddUpdateResi> {
  var _formKey = GlobalKey<FormState>();
  var _controllerKdResi = TextEditingController();
  var _controllerKeterangan = TextEditingController();

  @override
  void initState() {
    if (widget.resi != null) {
      _controllerKdResi.text = widget.resi!.kdResi!;
      _controllerKeterangan.text = widget.resi!.keterangan!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.resi == null ? 'Tambah Resi' : 'Update Resi'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerKdResi,
              decoration: InputDecoration(labelText: 'Nomor Resi'),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerKeterangan,
              decoration: InputDecoration(labelText: 'Keterangan'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.resi == null) {
                    String message = await EventDB.addResi(
                      _controllerKdResi.text,
                      _controllerKeterangan.text,
                    );
                    Info.snackbar(message);
                    if (message.contains('Berhasil')) {
                      _controllerKdResi.clear();
                      _controllerKeterangan.clear();
                    }
                  } else {
                    //.UpdateResi(
                    //_controllerKdResi.text,
                    //_controllerKeterangan.text,
                    //);
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Asset.colorAccent),
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.black),
              ),
              child: Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }
}
