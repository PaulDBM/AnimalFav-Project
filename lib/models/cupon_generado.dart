import 'dart:convert';

import 'package:http/http.dart';

import '../env.sample.dart';

class CuponGenerado {
  final String codigo;
  final DateTime expiracion;
  final int cupon;
  final int tipocupon;
  bool canjeado;
  String fechacanjeo;

  CuponGenerado(
      {required this.codigo,
      required this.expiracion,
      required this.cupon,
      required this.tipocupon,
      this.canjeado = false,
      this.fechacanjeo = ""});

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

  Future<Response> canjearCupon() {
    canjeado = true;
    fechacanjeo = DateTime.now().toString();
    final response = put(
      Uri.parse("${Env.urlprefix}/api/cupon/$codigo"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'canjeado': canjeado.toString(),
        'codigo': codigo,
        'expiracion': expiracion.toString(),
        'fecha_canjeo': fechacanjeo,
        'cupon': cupon.toString(),
        'tipo_cupon': tipocupon.toString(),
      }),
    );
    return response;
  }
}
