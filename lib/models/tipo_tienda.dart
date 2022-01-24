class TipoTienda {
  final int id;
  final String nombre;
  final String descripcion;

  TipoTienda(
      {required this.id, required this.nombre, required this.descripcion});

  factory TipoTienda.fromJson(Map<String, dynamic> json) {
    return TipoTienda(
      id: json['id'],
      descripcion: json['nombre'],
      nombre: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': descripcion,
        'descripcion': nombre,
      };
}
