class Pendapatan {
  String? idIncome;
  String? pendapatan;
  String? date;
  String? keterangan;
  String? idUser;

  Pendapatan({
    this.idIncome,
    this.pendapatan,
    this.date,
    this.keterangan,
    this.idUser,
  });

  factory Pendapatan.fromJson(Map<String, dynamic> json) => Pendapatan(
        idIncome: json['id_income'],
        pendapatan: json['pendapatan'],
        date: json['date'],
        keterangan: json['keterangan'],
        idUser: json['id_user'],
      );

  Map<String, dynamic> toJson() => {
        'id_income': this.idIncome,
        'pendapatan': this.pendapatan,
        'date': this.date,
        'keterangan': this.keterangan,
        'id_user': this.idUser,
      };
}
