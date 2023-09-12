class Task {
  String? idTask;
  String? taskName;
  String? description;
  String? progress;
  String? idUser;
  String? image;
  String? pointTugas;

  Task({
    this.description,
    this.idTask,
    this.idUser,
    this.progress,
    this.taskName,
    this.image,
    this.pointTugas,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        description: json['description'],
        idTask: json['id_task'],
        idUser: json['id_user'],
        progress: json['progress'],
        taskName: json['task_name'],
        image: json['image'],
        pointTugas: json['point_tugas'],
      );

  Map<String, dynamic> toJson(String imageBase64) => {
        'description': this.description,
        'id_task': this.idTask,
        'id_user': this.idUser,
        'progress': this.progress,
        'task_name': this.taskName,
        'point_tugas': this.pointTugas,
        'image': this.image,
        'image_file': imageBase64,
      };
}
