import 'package:flutter/material.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/event/event_db.dart';

class Login extends StatelessWidget {
  var _controllerNohp = TextEditingController();
  var _controllerPass = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.green,
                      Colors.blue,
                    ]),
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 20,
                bottom: 20,
              ),
              child: Text(
                'Daily Report',
                style: TextStyle(
                  fontSize: 35,
                  color: Asset.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: _controllerNohp,
                      style: TextStyle(
                        color: Asset.colorPrimaryDark,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ID Pegawai',
                        hintStyle: TextStyle(
                          color: Asset.colorPrimaryDark,
                        ),
                        fillColor: Asset.colorSecondary,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Asset.colorSecondary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Asset.colorPrimaryDark,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Asset.colorSecondary,
                            width: 1,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Asset.colorPrimaryDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: _controllerPass,
                      style: TextStyle(
                        color: Asset.colorPrimaryDark,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*******',
                        hintStyle: TextStyle(
                          color: Asset.colorPrimaryDark,
                        ),
                        fillColor: Asset.colorSecondary,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Asset.colorSecondary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Asset.colorPrimaryDark,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Asset.colorSecondary,
                            width: 1,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Asset.colorPrimaryDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Material(
                      color: Asset.colorAccent,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            EventDB.login(
                                _controllerNohp.text, _controllerPass.text);
                            _controllerNohp.clear();
                            _controllerPass.clear();
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
