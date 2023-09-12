import 'package:get/get.dart';
import 'package:monitoring_pegawai/model/leaderboard.dart';

class CLeaderboard extends GetxController {
  Rx<Leaderboard> _leaderboard = Leaderboard().obs;

  Leaderboard get leaderboard => _leaderboard.value;

  void setLeaderboard(Leaderboard dataLeaderboard) =>
      _leaderboard.value = dataLeaderboard;
}
