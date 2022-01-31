class RecorridoA {
  final int id;
  final String nombre;
  final String correo;
  final String dia;
  final dynamic duracion;
  final String ubicacion;
  final String descRecorrido;

  RecorridoA(
      {required this.id,
        required this.nombre,
        required this.correo,
        required this.dia,
        required this.duracion,
        required this.ubicacion,
        required this.descRecorrido});

  factory RecorridoA.fromJson(Map<String, dynamic> json) {
    return RecorridoA(
        id: json['id'],
        nombre: json['nombre'],
        correo: json['correo'],
        dia: json['dia'],
        duracion:  json['duracion'],
        ubicacion: json['ubicacion'],
        descRecorrido: json['descRecorrido']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'correo': correo,
    'dia': dia,
    'duracion': duracion,
    'ubicacion': ubicacion,
    'descRecorrido': descRecorrido,
  };
}
