class Leaderboard {
  String? idUser;
  String? kdRespon;
  String? name;
  String? score;

  Leaderboard({this.idUser, this.kdRespon, this.name, this.score});

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        idUser: json['id_user'],
        kdRespon: json['kd_respon'],
        name: json['name'],
        score: json['score'],
      );

  Map<String, dynamic> toJson() => {
        'id_user': this.idUser,
        'kd_respon': this.kdRespon,
        'name': this.name,
        'score': this.score,
      };
}
