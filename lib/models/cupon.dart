class Cupon {
  final int id;
  final String nombre;
  final String expiracion;
  final int tipotienda;
  String nombreTipoTienda;

  Cupon(
      {required this.id,
      required this.nombre,
      required this.expiracion,
      required this.tipotienda,
      this.nombreTipoTienda = ""});

  factory Cupon.fromJson(Map<String, dynamic> json) {
    return Cupon(
        id: json['id'],
        nombre: json['nombre'],
        expiracion: json['expiracion'],
        tipotienda: json['tipo_tienda']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'expiracion': expiracion,
        'tipo_tienda': tipotienda,
      };
}
