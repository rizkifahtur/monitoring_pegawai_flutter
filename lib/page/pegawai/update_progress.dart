// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monitoring_pegawai/config/api.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_task.dart';
import 'package:monitoring_pegawai/event/event_db.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/page/pegawai/dashboard_pegawai.dart';
import 'package:monitoring_pegawai/page/pegawai/list_task.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class UpdateProgress extends StatefulWidget {
  final Task task;
  UpdateProgress({required this.task});

  @override
  _UpdateProgressState createState() => _UpdateProgressState();
}

class _UpdateProgressState extends State<UpdateProgress> {
  double progress = 0;
  CTask _cTask = Get.put(CTask());
  RxList<int> _imageByte = <int>[].obs;
  RxString _imageName = ''.obs;
  void setImage(Uint8List newImage) => _imageByte.value = newImage;
  Uint8List get imageByte => Uint8List.fromList(_imageByte);
  void setImageName(String newName) => _imageName.value = newName;
  String get imageName => _imageName.value;

  void pickImage() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setImage(bytes);
      setImageName(path.basename(pickedFile.path));
    }
  }

  void addData() async {
    Task task = Task(
      idTask: widget.task.idTask,
      idUser: widget.task.idUser,
      progress: progress.round().toString(),
      taskName: widget.task.taskName,
      description: widget.task.description,
      pointTugas: widget.task.pointTugas,
      image: imageName,
    );
    try {
      var response = await http.post(
        Uri.parse(Api.updateProgress),
        body: task.toJson(base64Encode(imageByte)),
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody['success']);
        Get.to(DashboardPegawai());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    progress = double.parse(widget.task.progress ?? '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = Color.fromRGBO(30, 236, 174, 1);
    final inactiveColor = Color.fromRGBO(109, 114, 120, 1);

    const double thumbRadius = 18;
    const double tickMarkRadius = 8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Progress'),
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
          Text(
            widget.task.taskName ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            widget.task.description ?? '',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Text(
            widget.task.pointTugas ?? '',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${progress.round()}%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SliderTheme(
              data: SliderThemeData(

                  //active
                  thumbColor: activeColor,
                  activeTickMarkColor: activeColor,
                  activeTrackColor: activeColor,

                  //inactive
                  inactiveTickMarkColor: inactiveColor,
                  inactiveTrackColor: inactiveColor,

                  //thumb
                  trackHeight: 5,
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: thumbRadius,
                    disabledThumbRadius: thumbRadius,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                      value: progress,
                      onChanged: (value) => setState(() => progress = value),
                      min: 0,
                      max: 100,
                      label: '${progress.round()}%',
                      divisions: 100,
                      thumbColor: Colors.greenAccent),
                ],
              )),
          SizedBox(height: 20),
          Material(
            elevation: 8,
            color: Asset.colorPrimary,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              onTap: () => pickImage(),
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Text(
                  'Ambil Gambar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Obx(() => ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  maxHeight: MediaQuery.of(context).size.width * 0.5,
                ),
                child: imageByte.length > 0
                    ? Image.memory(
                        imageByte,
                        fit: BoxFit.contain,
                      )
                    : Placeholder(),
              )),
          SizedBox(height: 16),
          SizedBox(height: 20),
          Material(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              onTap: () => addData(),
              //EventDB.updateProgress(
              //  progress.round().toString(),
              //  widget.task.idTask!,
              //);

              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 12,
                ),
                child: Text(
                  'Selesaikan Pekerjaan',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
