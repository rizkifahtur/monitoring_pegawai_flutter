import 'package:get/get.dart';
import 'package:monitoring_pegawai/model/pegawai.dart';
import 'package:monitoring_pegawai/model/user.dart';

class CPegawai extends GetxController {
  Rx<Pegawai> _pegawai = Pegawai().obs;

  Pegawai get pegawai => _pegawai.value;

  void setUser(Pegawai dataPegawai) => _pegawai.value = dataPegawai;
}
