class TaskImage {
  String? idTask;
  String? taskName;
  String? description;
  String? progress;
  String? idUser;

  TaskImage({
    this.description,
    this.idTask,
    this.idUser,
    this.progress,
    this.taskName,
  });

  factory TaskImage.fromJson(Map<String, dynamic> json) => TaskImage(
        description: json['description'],
        idTask: json['id_task'],
        idUser: json['id_user'],
        progress: json['progress'],
        taskName: json['task_name'],
      );

  Map<String, dynamic> toJson() => {
        'description': this.description,
        'id_task': this.idTask,
        'id_user': this.idUser,
        'progress': this.progress,
        'task_name': this.taskName,
      };
}
