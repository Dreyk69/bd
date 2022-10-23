class Pos {
  final int? id;
  final String title;
  final String description;
  final int? cena;
  final int? kol;

  Pos({required this.id, required this.title, required this.description, required this.cena, required this.kol});

  factory Pos.fromJson(Map<String, dynamic> json) => Pos(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        cena: json['cena'],
        kol: json['kol']
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'cena': cena,
        'kol': kol
      };
}