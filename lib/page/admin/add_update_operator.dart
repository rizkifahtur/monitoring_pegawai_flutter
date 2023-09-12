import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/widget/info.dart';

class AddUpdateOperator extends StatefulWidget {
  final User? user;

  AddUpdateOperator({this.user});

  @override
  _AddUpdateJobState createState() => _AddUpdateJobState();
}

class _AddUpdateJobState extends State<AddUpdateOperator> {
  var _formKey = GlobalKey<FormState>();
  var _controllerName = TextEditingController();
  var _controllerNohp = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerAddress = TextEditingController();
  var _controllerReward = TextEditingController();
  var _controllerDescription = TextEditingController();

  @override
  void initState() {
    if (widget.user != null) {
      _controllerName.text = widget.user!.name!;
      _controllerNohp.text = widget.user!.nohp!;
      _controllerPassword.text = widget.user!.pass!;
      _controllerAddress.text = widget.user!.address!;
      _controllerReward.text = widget.user!.reward!;
      _controllerDescription.text = widget.user!.description!;
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
        title:
            Text(widget.user == null ? 'Tambah Operator' : 'Update Operator'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerName,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Asset.colorSecondary,
                        width: 1,
                      ))),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerNohp,
              decoration: InputDecoration(
                  labelText: 'No.HP',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Asset.colorSecondary,
                        width: 1,
                      ))),
            ),
            SizedBox(height: 16),
            TextFormField(
              enabled: widget.user == null ? true : false,
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerPassword,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Asset.colorSecondary,
                        width: 1,
                      ))),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (value) => value == '' ? 'jangan Kosong' : null,
              controller: _controllerAddress,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Asset.colorSecondary))),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.user == null) {
                    String message = await EventDB.addUser(
                      _controllerName.text,
                      _controllerNohp.text,
                      _controllerPassword.text,
                      'Operator',
                      _controllerAddress.text,
                      'op',
                      _controllerReward.text,
                      _controllerDescription.text,
                    );
                    Info.snackbar(message);
                    if (message.contains('Berhasil')) {
                      _controllerName.clear();
                      _controllerNohp.clear();
                      _controllerPassword.clear();
                      _controllerAddress.clear();
                    }
                  } else {
                    EventDB.updateUser(
                      widget.user!.idUser!,
                      _controllerName.text,
                      _controllerNohp.text,
                      'Operator',
                      _controllerAddress.text,
                      'op',
                      _controllerReward.text,
                      _controllerDescription.text,
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).colorScheme.onPrimary,
                primary: Colors.green,
                fixedSize: Size.fromWidth(100),
              ),
              child: Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }
}
