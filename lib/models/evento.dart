class EventoA {
  final int id;
  final String nombre;
  final String correo;
  final String dia;
  final dynamic duracion;
  final String ubicacion;

  EventoA(
      {required this.id,
        required this.nombre,
        required this.correo,
        required this.dia,
        required this.duracion,
        required this.ubicacion});

  factory EventoA.fromJson(Map<String, dynamic> json) {
    return EventoA(
        id: json['id'],
        nombre: json['nombre'],
        correo: json['correo'],
        dia: json['dia'],
        duracion:  json['duracion'],
        ubicacion: json['ubicacion']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'correo': correo,
    'dia': dia,
    'duracion': duracion,
    'ubicacion': ubicacion
  };
}
