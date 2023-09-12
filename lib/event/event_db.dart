import 'dart:convert';
import 'package:get/get.dart';
import 'package:monitoring_pegawai/config/api.dart';
import 'package:monitoring_pegawai/event/event_pref.dart';
import 'package:monitoring_pegawai/model/job.dart';
import 'package:monitoring_pegawai/model/leaderboard.dart';
import 'package:monitoring_pegawai/model/notif.dart';
import 'package:monitoring_pegawai/model/pendapatan.dart';
import 'package:monitoring_pegawai/model/resi.dart';
import 'package:monitoring_pegawai/model/task.dart';
import 'package:monitoring_pegawai/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring_pegawai/page/admin/dashboard_admin.dart';
import 'package:monitoring_pegawai/page/operator/dashboard_operator.dart';
import 'package:monitoring_pegawai/page/pegawai/add_update_pendapatan.dart';
import 'package:monitoring_pegawai/page/pegawai/add_update_resi.dart';
import 'package:monitoring_pegawai/page/pegawai/dashboard_pegawai.dart';
import 'package:monitoring_pegawai/widget/info.dart';

class EventDB {
  static Future<User?> login(String nohp, String pass) async {
    User? user;
    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'nohp': nohp,
        'pass': pass,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          user = User.fromJson(responseBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
          Future.delayed(Duration(milliseconds: 1700), () {
            Get.off(
              user!.role == 'Pegawai'
                  ? DashboardPegawai()
                  : user.role == 'Operator'
                      ? DashboardOperator()
                      : DashboardAdmin(),
            );
          });
        } else {
          Info.snackbar('Login Gagal');
        }
      } else {
        Info.snackbar('Request Login Gagal');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<List<User>> getUser(String role) async {
    List<User> listUser = [];
    try {
      var response = await http.post(Uri.parse(Api.getUsers), body: {
        'role': role,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var users = responseBody['user'];
          users.forEach((user) {
            listUser.add(User.fromJson(user));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listUser;
  }

  static Future<List<Job>> getJob() async {
    List<Job> listJob = [];
    try {
      var response = await http.get(Uri.parse(Api.getJobs));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var jobs = responseBody['job'];
          jobs.forEach((job) {
            listJob.add(Job.fromJson(job));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listJob;
  }

  static Future<List<Resi>> getResi() async {
    List<Resi> listResi = [];
    try {
      var response = await http.get(Uri.parse(Api.getResis));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var resis = responseBody['resi'];
          resis.forEach((resi) {
            listResi.add(Resi.fromJson(resi));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listResi;
  }

  static Future<List<Notif>> getNotif() async {
    List<Notif> listNotif = [];
    try {
      var response = await http.get(Uri.parse(Api.getNotif));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var notif = responseBody['notif'];
          notif.forEach((notif) {
            listNotif.add(Notif.fromJson(notif));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listNotif;
  }

  static Future<List<Leaderboard>> getLeaderboard() async {
    List<Leaderboard> listLeaderboard = [];
    try {
      var response = await http.get(Uri.parse(Api.getLeaderboard));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var leaderboard = responseBody['leaderboard'];
          leaderboard.forEach((leaderboard) {
            listLeaderboard.add(Leaderboard.fromJson(leaderboard));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listLeaderboard;
  }

  static Future resetData() async {
    try {
      var response = await http.get(Uri.parse(Api.resetData));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future inputReward() async {
    try {
      var response = await http.get(Uri.parse(Api.inputReward));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future inputPunishment() async {
    try {
      var response = await http.get(Uri.parse(Api.inputPunishment));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Pendapatan>> getPendapatan() async {
    List<Pendapatan> listPendapatan = [];
    try {
      var response = await http.get(Uri.parse(Api.getPendapatans));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var pendapatan = responseBody['pendapatan'];
          pendapatan.forEach((pendapatan) {
            listPendapatan.add(Pendapatan.fromJson(pendapatan));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listPendapatan;
  }

  static Future<String> addJob(String id, String name, String salary) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addJob), body: {
        'id_job': id,
        'job_name': name,
        'salary': salary,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          reason = 'Berhasil Tambah Pekerjaan';
        } else {
          reason = responseBody['reason'];
        }
      } else {
        reason = 'Request Gagal';
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<String> addResi(String kdResi, String keterangan) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addResi), body: {
        'kd_resi': kdResi,
        'keterangan': keterangan,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          reason = 'Berhasil Tambah Resi';
        } else {
          reason = responseBody['reason'];
        }
      } else {
        reason = 'Request Gagal';
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<void> updateJob(String id, String name, String salary) async {
    try {
      var response = await http.post(Uri.parse(Api.updateJob), body: {
        'id_job': id,
        'job_name': name,
        'salary': salary,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Update');
        } else {
          Info.snackbar('Gagal Update');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteResi(String id) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteResi), body: {
        'id_resi': id,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Delete');
        } else {
          Info.snackbar('Gagal Delete');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deletePendapatan(String id) async {
    try {
      var response = await http.post(Uri.parse(Api.deletePendapatan), body: {
        'id_income': id,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Delete');
        } else {
          Info.snackbar('Gagal Delete');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteJob(String id) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteJob), body: {
        'id_job': id,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Delete');
        } else {
          Info.snackbar('Gagal Delete');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<String> addUser(
      String name,
      String nohp,
      String pass,
      String role,
      String address,
      String idJob,
      String reward,
      String description) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addUser), body: {
        'name': name,
        'nohp': nohp,
        'pass': pass,
        'role': role,
        'address': address,
        'id_job': idJob,
        'reward': reward,
        'description': description,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          reason = 'Berhasil Tambah $role';
        } else {
          reason = responseBody['reason'];
        }
      } else {
        reason = 'Request Gagal';
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<void> updateUser(
      String idUser,
      String name,
      String nohp,
      String role,
      String address,
      String idJob,
      String reward,
      String description) async {
    try {
      var response = await http.post(Uri.parse(Api.updateUser), body: {
        'id_user': idUser,
        'name': name,
        'nohp': nohp,
        'role': role,
        'address': address,
        'id_job': idJob,
        'reward': reward,
        'description': description,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Update $role');
        } else {
          Info.snackbar('Gagal Update $role');
        }
      } else {
        Info.snackbar('Request Gagal');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteUser(String id) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteUser), body: {
        'id_user': id,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Delete');
        } else {
          Info.snackbar('Gagal Delete');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Task>> getTask(String idUser) async {
    List<Task> listTask = [];
    try {
      var response = await http.post(Uri.parse(Api.getTasks), body: {
        'id_user': idUser,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var tasks = responseBody['task'];
          tasks.forEach((task) {
            listTask.add(Task.fromJson(task));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listTask;
  }

  static Future<String> addTask(String taskName, String description,
      String pointTugas, String idUser) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addTask), body: {
        'task_name': taskName,
        'description': description,
        'point_tugas': pointTugas,
        'id_user': idUser,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          reason = 'Berhasil Tambah Tugas';
        } else {
          reason = 'Gagal Tambah Tugas';
        }
      } else {
        reason = 'Request Gagal';
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<String> AddPendapatan(
      String pendapatan, String keterangan, String idUser) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addPendapatan), body: {
        'pendapatan': pendapatan,
        'keterangan': keterangan,
        'id_user': idUser,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          reason = 'Berhasil Tambah Pendapatan';
        } else {
          reason = 'Gagal Tambah Pendapatan';
        }
      } else {
        reason = 'Request Gagal';
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<void> updateTask(String taskName, String description,
      String pointTugas, String idTask) async {
    try {
      var response = await http.post(Uri.parse(Api.updateTask), body: {
        'task_name': taskName,
        'description': description,
        'id_task': idTask,
        'point_tugas': pointTugas,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Update Tugas');
        } else {
          Info.snackbar('Gagal Update Tugas');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteTask(String id) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteTask), body: {
        'id_task': id,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Delete');
        } else {
          Info.snackbar('Gagal Delete');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateProgress(
      String progress, String idTask, String image) async {
    try {
      var response = await http.post(Uri.parse(Api.updateProgress), body: {
        'progress': progress,
        'id_task': idTask,
        'image': image,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Info.snackbar('Berhasil Update Progress');
        } else {
          Info.snackbar('Gagal Update Progress');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
