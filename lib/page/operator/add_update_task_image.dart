import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';

import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/widget/info.dart';

class AddUpdateTaskImage extends StatefulWidget {
  final Task? task;
  final String idUser;

  AddUpdateTaskImage({this.task, required this.idUser});

  @override
  _AddUpdateJobImageState createState() => _AddUpdateJobImageState();
}

class _AddUpdateJobImageState extends State<AddUpdateTaskImage> {
  var _formKey = GlobalKey<FormState>();
  var _controllerTaskName = TextEditingController();
  var _controllerDescription = TextEditingController();
  var _controllerPointTugas = TextEditingController();

  @override
  void initState() {
    if (widget.task != null) {
      _controllerTaskName.text = widget.task!.taskName!;
      _controllerDescription.text = widget.task!.description!;
      _controllerPointTugas.text = widget.task!.pointTugas!;
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
        title: Text(widget.task == null ? 'Tambah Tugas' : 'Update Tugas'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerTaskName,
              decoration: InputDecoration(labelText: 'Nama Tugas'),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerPointTugas,
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration(labelText: 'Point Tugas'),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerDescription,
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.task == null) {
                    String message = await EventDB.addTask(
                      _controllerTaskName.text,
                      _controllerDescription.text,
                      _controllerPointTugas.text,
                      widget.idUser,
                    );
                    Info.snackbar(message);
                    if (message.contains('Berhasil')) {
                      _controllerTaskName.clear();
                      _controllerDescription.clear();
                    }
                  } else {
                    EventDB.updateTask(
                      _controllerTaskName.text,
                      _controllerDescription.text,
                      _controllerPointTugas.text,
                      widget.task!.idTask!,
                    );
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
