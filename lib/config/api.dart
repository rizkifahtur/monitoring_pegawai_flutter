class Api {
  static const _host = 'http://192.168.4.83/api_monitoring_pegawai';
  static String _job = '$_host/job';
  static String _task = '$_host/task';
  static String _user = '$_host/user';
  static String _resi = '$_host/resi';
  static String _leaderboard = '$_host/leaderboard';
  static String _notif = '$_host/notif';
  static String _pendapatan = '$_host/pendapatan';
  static const hostImage = '$_host/images/';
  static String login = '$_host/login.php';

  /// Job
  static String addJob = '$_job/add_job.php';
  static String deleteJob = '$_job/delete_job.php';
  static String getJobs = '$_job/get_jobs.php';
  static String updateJob = '$_job/update_job.php';

  // Resi
  static String addResi = '$_resi/add_resi.php';
  static String deleteResi = '$_resi/delete_resi.php';
  static String getResis = '$_resi/get_resis.php';

  static String updateResi = '$_resi/update_resi.php';

  //Notif
  static String getNotif = '$_notif/get_notif.php';

  //Leaderboard
  static String getLeaderboard = '$_leaderboard/get_leaderboard.php';
  static String resetData = '$_leaderboard/reset_data.php';
  static String inputReward = '$_leaderboard/input_reward.php';
  static String inputPunishment = '$_leaderboard/input_punishment.php';

  /// Task
  static String addTask = '$_task/add_task.php';
  static String deleteTask = '$_task/delete_task.php';
  static String getTasks = '$_task/get_tasks.php';
  static String updateTask = '$_task/update_task.php';
  static String updateProgress = '$_task/update_progress.php';

  // Pendapatan
  static String addPendapatan = '$_pendapatan/add_pendapatan.php';
  static String deletePendapatan = '$_pendapatan/delete_pendapatan.php';
  static String getPendapatans = '$_pendapatan/get_pendapatans.php';
  static String updatePendapatan = '$_pendapatan/update_pendapatan.php';

  /// User
  static String addUser = '$_user/add_user.php';
  static String deleteUser = '$_user/delete_user.php';
  static String getUsers = '$_user/get_users.php';
  static String updateUser = '$_user/update_user.php';
}
