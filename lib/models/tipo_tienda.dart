class TipoTienda {
  final int id;
  final String nombre;
  final String descripcion;

  TipoTienda(
      {required this.id, required this.nombre, required this.descripcion});

  factory TipoTienda.fromJson(Map<String, dynamic> json) {
    return TipoTienda(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
      };
}
