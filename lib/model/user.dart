class User {
  String? idUser;
  String? name;
  String? nohp;
  String? pass;
  String? role;
  String? address;
  String? idJob;
  String? jobName;
  String? salary;
  String? reward;
  String? description;

  User({
    this.address,
    this.idJob,
    this.idUser,
    this.jobName,
    this.name,
    this.nohp,
    this.pass,
    this.role,
    this.salary,
    this.reward,
    this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        address: json['address'],
        idJob: json['id_job'],
        idUser: json['id_user'],
        jobName: json['job_name'],
        name: json['name'],
        nohp: json['nohp'],
        pass: json['pass'],
        role: json['role'],
        salary: json['salary'],
        reward: json['reward'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'address': this.address,
        'id_job': this.idJob,
        'id_user': this.idUser,
        'job_name': this.jobName,
        'name': this.name,
        'nohp': this.nohp,
        'pass': this.pass,
        'role': this.role,
        'salary': this.salary,
        'reward': this.reward,
        'description': this.description,
      };
}
