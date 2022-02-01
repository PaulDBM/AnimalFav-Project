class CuponGenerado {
  final String codigo;
  final DateTime expiracion;
  final int cupon;
  final int tipocupon;

  CuponGenerado(
      {required this.codigo,
      required this.expiracion,
      required this.cupon,
      required this.tipocupon});

  factory CuponGenerado.fromJson(Map<String, dynamic> json) {
    return CuponGenerado(
        codigo: json['codigo'],
        expiracion: json['expiracion'],
        cupon: json['cupon'],
        tipocupon: json['tipo_cupon']);
  }

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'expiracion': expiracion,
        'cupon': cupon,
        'tipo_cupon': tipocupon,
      };
}
