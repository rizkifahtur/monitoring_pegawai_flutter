class Notif {
  String? idUser;
  String? idNotif;
  String? description;
  String? taskName;
  String? progress;

  Notif(
      {this.idUser,
      this.idNotif,
      this.taskName,
      this.progress,
      this.description});

  factory Notif.fromJson(Map<String, dynamic> json) => Notif(
        idUser: json['id_user'],
        idNotif: json['id_notif'],
        description: json['description'],
        taskName: json['task_name'],
        progress: json['progress'],
      );

  Map<String, dynamic> toJson() => {
        'id_user': this.idUser,
        'id_notif': this.idNotif,
        'description': this.description,
        'task_name': this.taskName,
        'progress': this.progress,
      };
}
