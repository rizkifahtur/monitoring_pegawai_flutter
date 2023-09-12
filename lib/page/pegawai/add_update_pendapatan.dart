import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_user.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/pendapatan.dart';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/widget/info.dart';

class AddUpdatePendapatan extends StatefulWidget {
  final Pendapatan? pendapatan;

  AddUpdatePendapatan({this.pendapatan});

  @override
  _AddUpdatePendapatanState createState() => _AddUpdatePendapatanState();
}

class _AddUpdatePendapatanState extends State<AddUpdatePendapatan> {
  var _formKey = GlobalKey<FormState>();
  var _controllerPendapatan = TextEditingController();
  var _controllerKeterangan = TextEditingController();
  CUser _cUser = Get.put(CUser());

  @override
  void initState() {
    if (widget.pendapatan != null) {
      _controllerPendapatan.text = widget.pendapatan!.pendapatan!;
      _controllerKeterangan.text = widget.pendapatan!.keterangan!;
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
        title: Text(widget.pendapatan == null
            ? 'Tambah Pendapatan'
            : 'Update Pendapatan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerPendapatan,
              decoration: InputDecoration(labelText: 'Pendapatan'),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerKeterangan,
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration(labelText: 'Keterangan'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.pendapatan == null) {
                    String message = await EventDB.AddPendapatan(
                      _controllerPendapatan.text,
                      _controllerKeterangan.text,
                      _cUser.user.name!,
                    );
                    Info.snackbar(message);
                    if (message.contains('Berhasil')) {
                      _controllerPendapatan.clear();
                      _controllerKeterangan.clear();
                    }
                  } else {
                    //EventDB.updateTask(
                    //  _controllerTaskName.text,
                    //  _controllerDescription.text,
                    //  widget.task!.idTask!,
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
