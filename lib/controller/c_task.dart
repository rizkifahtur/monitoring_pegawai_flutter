import 'package:get/get.dart';
import 'package:monitoring_pegawai/model/task.dart';

class CTask extends GetxController {
  Rx<Task> _task = Task().obs;

  Task get task => _task.value;

  void setTask(Task dataTask) => _task.value = dataTask;
}
