class Resi {
  String? idResi;
  String? kdResi;
  String? keterangan;
  String? date;

  Resi({this.idResi, this.kdResi, this.keterangan, this.date});

  factory Resi.fromJson(Map<String, dynamic> json) => Resi(
        idResi: json['id_resi'],
        kdResi: json['kd_resi'],
        keterangan: json['keterangan'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id_resi': this.idResi,
        'kd_resi': this.kdResi,
        'keterangan': this.keterangan,
        'date': this.date,
      };
}
