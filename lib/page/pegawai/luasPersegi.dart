import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/job.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:monitoring_pegawai/widget/info.dart';

class luasPersegi extends StatefulWidget {
  final User? user;

  luasPersegi({this.user});

  @override
  _luasPersegiState createState() => _luasPersegiState();
}

class _luasPersegiState extends State<luasPersegi> {
  var _formKey = GlobalKey<FormState>();
  var _controllerPanjang = TextEditingController();
  var _controllerLebar = TextEditingController();

  @override
  void initState() {
    if (widget.user != null) {
      _controllerPanjang.text = widget.user!.name!;
      _controllerLebar.text = widget.user!.nohp!;
    }
    super.initState();
  }

  @override
  showAlertDialog(BuildContext context) {
    // set up the buttons

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Luas Persegi Panjang"),
      content: Text("20"),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: Text('Persegi Panjang'),
              tileColor: Asset.colorRed,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) => value == '' ? 'jangan Kosong' : null,
                    controller: _controllerPanjang,
                    decoration: InputDecoration(labelText: 'Panjang'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) => value == '' ? 'jangan Kosong' : null,
                    controller: _controllerLebar,
                    decoration: InputDecoration(labelText: 'Lebar'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Asset.colorAccent),
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black),
                      ),
                      child: Text('SIMPAN'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
