class TipoCupon {
  final int id;
  final String nombre;

  TipoCupon({required this.id, required this.nombre});

  factory TipoCupon.fromJson(Map<String, dynamic> json) {
    return TipoCupon(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };
}
