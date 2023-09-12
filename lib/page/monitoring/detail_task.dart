import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:monitoring_pegawai/config/api.dart';
import 'package:monitoring_pegawai/config/asset.dart';
import 'package:monitoring_pegawai/controller/c_task.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class DetailTask extends StatelessWidget {
  final Task task;

  DetailTask({required this.task});
  CTask _cTask = Get.put(CTask());

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = double.parse(task.progress ?? '0');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tugas'),
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
            task.taskName ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            task.description ?? '',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Text(
            task.pointTugas ?? '',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          PieChart(
            dataMap: {
              'Selesai': progress,
              'Belum Selesai': 100 - progress,
            },
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width * 0.5,
            colorList: [
              Asset.colorAccent,
              Asset.colorSecondary,
            ],
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 28,
            centerText: '${progress.round()}%',
            legendOptions: LegendOptions(
              showLegends: false,
            ),
            chartValuesOptions: ChartValuesOptions(
              chartValueStyle: TextStyle(
                fontSize: 30,
                color: Asset.colorPrimaryDark,
              ),
              chartValueBackgroundColor: Colors.white,
              showChartValueBackground: true,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                color: Asset.colorAccent,
                width: 20,
                height: 20,
              ),
              SizedBox(width: 16),
              Text(
                'Selesai',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                color: Asset.colorSecondary,
                width: 20,
                height: 20,
              ),
              SizedBox(width: 16),
              Text(
                'Belum Selesai',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          buildTitle('Detail Foto Pekerjaan'),
          SizedBox(height: 8),
          FullScreenWidget(
            child: FadeInImage(
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.fitWidth,
              placeholder: AssetImage(Asset.imageBox),
              image: NetworkImage(Api.hostImage + task.image!),
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  child: Icon(Icons.broken_image),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Material(
            elevation: 2,
            color: progress < 100 ? Asset.colorSecondary : Asset.colorAccent,
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 12,
              ),
              child: Text(
                progress < 100 ? 'On-Progress' : 'Selesai',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: progress < 100 ? Asset.colorPrimaryDark : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
